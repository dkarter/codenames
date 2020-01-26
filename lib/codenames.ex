defmodule Codenames do
  alias Codenames.Game

  defdelegate new_game(board, teams), to: Game, as: :new
  defdelegate give_clue(game, number_of_guesses), to: Game
end
