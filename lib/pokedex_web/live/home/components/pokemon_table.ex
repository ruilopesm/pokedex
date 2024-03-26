defmodule PokedexWeb.HomeLive.Components.PokemonTable do
  @moduledoc false
  use PokedexWeb, :html

  attr :pokemons, :list, required: true

  def pokemon_table(assigns) do
    ~H"""
    <.table id="pokemon-table" rows={@pokemons}>
      <:col :let={pokemon} label="Number"><%= pokemon.number %></:col>
      <:col :let={pokemon} label="Name"><%= String.capitalize(pokemon.name) %></:col>
      <:col :let={pokemon} label="Searched at"><%= relative_datetime(pokemon.searched_at) %></:col>

      <:action :let={row}>
        <.button phx-click="show-pokemon" phx-value-number={row.number}>
          Show
        </.button>
      </:action>
    </.table>
    """
  end
end
