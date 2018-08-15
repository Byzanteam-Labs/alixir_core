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
    do_perfom(http_method, url, params: List.wrap(params), headers: List.wrap(headers), body: body)
  end

  @spec perform(%Request{http_method: :get, url: String.t()}) :: {:ok, status_code, body} | {:error, reason}
  def perform(%Request{http_method: :get, url: url})  do
    do_perfom(:get, url)
  end

  defp do_perfom(method, url, options \\ []) do
    case HTTPoison.request(method, url, options) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, 200, body}
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        {:ok, status_code, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
