defmodule Codenames.GameTest do
  use ExUnit.Case

  alias Codenames.Board
  alias Codenames.Card
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

  describe ".make_guess/2" do
    # Good guess (bleongs to your team):
    #   - update the card as revealed
    #   - decrement the number of guesses remaining
    #   - if there are remaining_guesses, make another guess
    #   - potentially game over - update game_state
    # Bad Guess (belongs to other team):
    #   - update the card as revealed
    #   - turn immediately switches over to other team
    #   - remaining guesses resets to 0
    #   - potentially game over - update game_state
    #
    test "decrements number of guesses on correct guess and waits for next guess" do
      game = Game.new(@board, @teams)

      assert %Game{
               game_state: :waiting_for_guess,
               remaining_guesses: 1
             } =
               game
               |> Game.give_clue(number_of_guesses: 2)
               |> Game.make_guess("ace")
    end

    test "reveals card if guess is valid (word is on the board and not revealed)" do
      game = Game.new(@board, @teams)

      assert %Game{board: board} =
               game
               |> Game.give_clue(number_of_guesses: 2)
               |> Game.make_guess("ace")

      assert board
             |> Enum.any?(fn card ->
               card == %Card{word: "ace", hidden_property: :red, seen: true}
             end)
    end
  end
end
