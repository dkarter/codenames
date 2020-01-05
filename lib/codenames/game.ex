defmodule Codenames.Game do
  @moduledoc """
  Manages game state
  """

  alias Codenames.Board

  defstruct [
    :blue_team,
    :board,
    :remaining_guesses,
    :current_team,
    :red_team,
    game_state: :not_started
  ]

  def new(%Board{} = board, %{red_team: red_team, blue_team: blue_team}) do
    %__MODULE__{
      game_state: :waiting_for_clue,
      current_team: :red,
      red_team: red_team,
      blue_team: blue_team,
      board: board
    }
  end
end
