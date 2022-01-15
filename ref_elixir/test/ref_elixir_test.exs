defmodule RefElixirTest do
  use ExUnit.Case
  doctest RefElixir

  test "greets the world" do
    assert RefElixir.hello() == :world
  end
end
