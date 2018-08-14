defmodule Alixir do
  alias Alixir.Request
  alias Alixir.Request.Operation

  @type status_code :: integer
  @type body :: String.t
  @type reason :: String.t

  @spec request(Operation.t) :: {:ok, status_code, body} | {:error, reason}
  def request(operation) do
    operation
    |> Operation.perform
    |> Request.perform
  end
end
