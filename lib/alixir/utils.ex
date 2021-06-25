defmodule Alixir.Utils do
  import Base, only: [encode64: 1]

  @encoding_mappings [
    {"+", "%20"},
    {"*", "%2A"},
    {"%7E", "~"}
  ]

  def sign(string_to_sign, key) do
    :hmac |> :crypto.mac(:sha, key, string_to_sign) |> encode64()
  end

  # POP 协议签名算法
  def url_encode(str, :pop) do
    Enum.reduce(@encoding_mappings, url_encode(str), fn {origin, target}, converted ->
      String.replace(converted, origin, target)
    end)
  end

  def url_encode(str) do
    URI.encode_www_form(str)
  end

  def gmt_now do
    Calendar.strftime(DateTime.utc_now(), "%a, %d %b %Y %H:%M:%S GMT")
  end

  def iso_8601_extended_gmt_now do
    Calendar.strftime(DateTime.utc_now(), "%xT%XZ")
  end

  def uuid do
    (:erlang.system_time(:nano_seconds) + :erlang.unique_integer([:monotonic]))
    |> :erlang.term_to_binary()
    |> Base.encode16()
  end
end
