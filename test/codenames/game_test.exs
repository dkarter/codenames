defmodule Codenames.GameTest do
  use ExUnit.Case

  alias Codenames.Board
  alias Codenames.Game

  @cards %{
    blue: ["apple", "bananna", "joker"],
    red: ["orange", "raspberry", "ace"],
    assasin: ["killer"],
    bystanders: ["person", "dude"]
  }

  @board Board.new(@cards)

  @red_team [clue_giver: "John", guesser: "Jane"]
  @blue_team [clue_giver: "Mike", guesser: "Michelle"]

  @teams %{red_team: @red_team, blue_team: @blue_team}

  describe ".new_game/2" do
    test "creates game initial state" do
      assert %Game{
               game_state: :waiting_for_clue,
               current_team: :red,
               red_team: @red_team,
               blue_team: @blue_team,
               board: @board
             } =
               @board
               |> Game.new(@teams)
    end
  end
end
