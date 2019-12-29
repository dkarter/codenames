defmodule Codenames.BoardTest do
  use ExUnit.Case

  alias Codenames.Board

  describe ".new" do
    test "creates a new board from input" do
      board_contents = %{
        blue: ["apple", "bananna", "joker"],
        red: ["orange", "raspberry", "ace"],
        assasin: ["killer"],
        bystanders: ["person", "dude"]
      }

      board = Codenames.Board.new(board_contents)

      assert %Board{} = board
      assert Map.from_struct(board) == board_contents
    end
  end
end
