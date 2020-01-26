defmodule Codenames.BoardTest do
  use ExUnit.Case

  alias Codenames.Board
  alias Codenames.Card

  @board_contents %{
    blue: ["apple", "bananna", "joker"],
    red: ["orange", "raspberry", "ace"],
    assasin: ["killer"],
    bystanders: ["person", "dude"]
  }

  describe ".new/1" do
    test "creates a new board from input" do
      board = Board.new(@board_contents)

      expected_result =
        [
          %Card{word: "apple", hidden_property: :blue, seen: false},
          %Card{word: "bananna", hidden_property: :blue, seen: false},
          %Card{word: "joker", hidden_property: :blue, seen: false},
          %Card{word: "orange", hidden_property: :red, seen: false},
          %Card{word: "raspberry", hidden_property: :red, seen: false},
          %Card{word: "ace", hidden_property: :red, seen: false},
          %Card{word: "killer", hidden_property: :assasin, seen: false},
          %Card{word: "person", hidden_property: :bystanders, seen: false},
          %Card{word: "dude", hidden_property: :bystanders, seen: false}
        ]
        |> Enum.sort()

      assert expected_result == board |> Enum.sort()
    end
  end

  describe ".reveal_card/2" do
    test "changes the seen property of the card to true and returns new board" do
      board = Board.new(@board_contents)

      assert board
             |> Board.reveal_card("apple")
             |> Enum.any?(fn card ->
               card.word == "apple" && card.seen == true
             end)
    end
  end
end
