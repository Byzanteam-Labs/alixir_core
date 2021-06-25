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
    Timex.format!(Timex.now(), "%a, %d %b %Y %H:%M:%S GMT", :strftime)
  end

  def iso_8601_extended_gmt_now do
    Timex.format!(Timex.now("GMT"), "%FT%TZ", :strftime)
  end
end
