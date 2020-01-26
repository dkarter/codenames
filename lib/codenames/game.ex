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
    error: nil,
    game_state: :not_started
  ]

  def new(board, %{red_team: red_team, blue_team: blue_team}) do
    %__MODULE__{
      game_state: :waiting_for_clue,
      current_team: :red,
      red_team: red_team,
      blue_team: blue_team,
      board: board
    }
  end

  def give_clue(%__MODULE__{} = game, number_of_guesses: number_of_guesses) do
    game
    |> Map.put(:remaining_guesses, number_of_guesses)
    |> Map.put(:game_state, :waiting_for_guess)
  end

  def make_guess(%__MODULE__{} = game, guess) do
    if Board.valid_guess?(game.board, guess) do
      new_board = Board.reveal_card(game.board, guess)
      %{game | board: new_board, remaining_guesses: game.remaining_guesses - 1}
    else
      %{game | error: "Invalid guess"}
    end
  end
end
