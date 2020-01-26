defmodule Codenames.CardTest do
  use ExUnit.Case

  alias Codenames.Card

  describe ".new/2" do
    test "creates a new hidden card struct" do
      assert %Card{
               word: "word",
               hidden_property: :blue,
               seen: false
             } = Card.new("word", :blue)
    end
  end
end
