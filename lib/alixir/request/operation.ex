defprotocol Alixir.Request.Operation do
  @fallback_to_any true

  def perform(operation)
end

defimpl Alixir.Request.Operation, for: Any do
  def perform(_), do: %Alixir.Request{}
end
