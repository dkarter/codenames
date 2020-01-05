defmodule CodenamesTest do
  use ExUnit.Case

  alias Codenames.Board

  @cards %{
    blue: ["apple", "bananna", "joker"],
    red: ["orange", "raspberry", "ace"],
    assasin: ["killer"],
    bystanders: ["person", "dude"]
  }

  describe "Integration" do
    test "simple game round" do
      game =
        @cards
        |> Board.new()
        |> Codenames.new_game(%{
          red_team: [clue_giver: "John", guesser: "Jane"],
          blue_team: [clue_giver: "Mike", guesser: "Michelle"]
        })
        # team: red
        |> Codenames.give_clue(number_of_guesses: 2)
        |> Codenames.make_guess("orange")
        |> Codenames.make_guess("ace")
        # team: blue
        |> Codenames.give_clue(number_of_guesses: 2)
        |> Codenames.make_guess("person")
        # team: red
        |> Codenames.give_clue(number_of_guesses: 1)
        |> Codenames.make_guess("raspberry")

      assert %{game_state: :game_over, winner: :red} = game
    end
  end
end
