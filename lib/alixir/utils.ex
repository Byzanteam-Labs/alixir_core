defmodule Alixir.Utils do
  import Base, only: [encode64: 1]

  @encoding_mappings [
    {"+", "%20"},
    {"*", "%2A"},
    {"~", "%7E"},
  ]

  def sign(string_to_sign, key) do
    :crypto.hmac(:sha, key, string_to_sign) |> encode64()
  end

  def url_encode(str) do
    encode64(str)
  end
  # POP 协议签名算法
  def url_encode({:pop, str}) do
    Enum.reduce(@encoding_mappings, url_encode(str), fn(origin, target) ->
      String.replace(origin, target)
    end)
  end

  def gmt_now do
    Timex.format!(Timex.now, "%a, %d %b %Y %H:%M:%S GMT", :strftime)
  end

  def canonicalized_parameters(parameters) do
    parameters
    |> Enum.map(fn {key, value} -> "#{key |> to_string() |> String.downcase()}:#{value}" end)
    |> Enum.sort()
    |> Enum.join("\n")
  end
end
