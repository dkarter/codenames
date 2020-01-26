defmodule Codenames.Card do
  @moduledoc """
  Contains information about a Codenames card
  """

  defstruct [:word, :hidden_property, :seen]

  @type hidden_property :: :red | :blue | :assasin | :bystander

  @type t :: %__MODULE__{
          word: String.t(),
          hidden_property: hidden_property(),
          seen: boolean()
        }

  @spec new(String.t(), hidden_property()) :: t()
  def new(word, hidden_property) do
    %__MODULE__{word: word, hidden_property: hidden_property, seen: false}
  end
end
