defmodule Codenames.Board do
  @moduledoc """
  Represents a codenames board containing all the words and their classification
  """

  defstruct [:assasin, :blue, :bystanders, :red]

  @type t :: %__MODULE__{
          assasin: nonempty_list(String.t()),
          blue: nonempty_list(String.t()),
          bystanders: nonempty_list(String.t()),
          red: nonempty_list(String.t())
        }

  @spec new(map()) :: t()
  def new(cards) do
    struct!(__MODULE__, cards)
  end
end
