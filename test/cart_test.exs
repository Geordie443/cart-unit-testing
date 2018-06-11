defmodule CartTest do
  use ExUnit.Case
  ExUnit.configure(exclude: :skip, trace: true)

  doctest Cart

  @tag :skip
  test "greets the world" do
    assert Cart.hello() == :world
  end
end
