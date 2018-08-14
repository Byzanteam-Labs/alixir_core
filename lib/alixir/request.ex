defmodule Alixir.Request do
  defstruct [
    :http_method,
    :url,
    :params,
    :headers,
    :body
  ]

  alias Alixir.Request

  @type status_code :: integer
  @type body :: String.t
  @type reason :: String.t

  @spec perform(%Request{}) :: {:ok, status_code, body} | {:error, reason}
  def perform(
    %Request{http_method: http_method, url: url, params: params, headers: headers, body: body}
  ) when http_method in ~w{put delete}a do
    case HTTPoison.request(http_method, url, body, headers, params: List.wrap(params)) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, 200, body}
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        {:ok, status_code, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
