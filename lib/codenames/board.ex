defmodule Codenames.Board do
  @moduledoc """
  Represents a codenames board containing all the words and their classification
  """

  alias Codenames.Card

  @type t :: list(Card.t())

  @type cards_map :: %{
          assasin: nonempty_list(String.t()),
          blue: nonempty_list(String.t()),
          bystanders: nonempty_list(String.t()),
          red: nonempty_list(String.t())
        }

  @spec new(cards_map()) :: t()
  def new(cards) do
    cards
    |> Enum.reduce([], fn {hidden_property, words}, acc ->
      cards = Enum.map(words, &Card.new(&1, hidden_property))
      acc ++ cards
    end)
    |> Enum.shuffle()
  end

  @doc """
  """
  @spec valid_guess?(t(), String.t()) :: boolean()
  def valid_guess?(board, guess) do
    Enum.any?(board, fn card -> card.word == guess && card.seen == false end)
  end

  @doc """
  Given a valid guess (card is on the board)
  Reutrns the board with a flipped card for the guess
  """
  @spec reveal_card(t(), String.t()) :: t()
  def reveal_card(board, guess) do
    Enum.map(board, fn
      %Card{word: ^guess} = card ->
        %{card | seen: true}

      card ->
        card
    end)
  end
end
