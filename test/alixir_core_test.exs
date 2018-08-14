defmodule AlixirCoreTest do
  use ExUnit.Case
  doctest AlixirCore

  test "greets the world" do
    assert AlixirCore.hello() == :world
  end
end
