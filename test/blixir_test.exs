defmodule BlixirTest do
  use ExUnit.Case
  doctest Blixir

  test "greets the world" do
    assert Blixir.hello() == :world
  end
end
