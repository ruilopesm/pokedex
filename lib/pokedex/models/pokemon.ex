defmodule Pokedex.Models.Pokemon do
  @moduledoc false
  defstruct [
    :name,
    :number,
    :hp,
    :attack,
    :defense,
    :speed,
    :types,
    :sprites
  ]
end
