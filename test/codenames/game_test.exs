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

  describe ".give_clue/2" do
    setup do
      game = Game.new(@board, @teams)
      {:ok, %{game: game}}
    end

    test "changes the number of guesses allowed", %{game: game} do
      assert %Game{
               remaining_guesses: 2
             } = Game.give_clue(game, number_of_guesses: 2)
    end

    test "changes game state to :waiting_for_guess", %{game: game} do
      assert %Game{
               game_state: :waiting_for_guess
             } = Game.give_clue(game, number_of_guesses: 2)
    end
  end
end
