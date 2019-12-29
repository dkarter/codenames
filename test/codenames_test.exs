defmodule CodenamesTest do
  use ExUnit.Case
  doctest Codenames

  test "greets the world" do
    assert Codenames.hello() == :world
  end
end
