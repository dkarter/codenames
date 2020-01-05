defmodule Codenames do
  alias Codenames.Game

  defdelegate new_game(board, teams), to: Game, as: :new
end
