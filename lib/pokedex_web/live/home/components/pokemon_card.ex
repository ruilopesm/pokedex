defmodule PokedexWeb.HomeLive.Components.PokemonCard do
  @moduledoc false
  use PokedexWeb, :html

  alias Pokedex.Models.Pokemon

  import PokedexWeb.HomeLive.Components.TypeBadge

  @min_number 1
  @max_number 1025

  attr :pokemon, Pokemon, required: true

  def pokemon_card(assigns) do
    ~H"""
    <div id="pokemon-card" class="w-full max-w-xs">
      <div class="flex flex-col items-center pb-10">
        <img
          class="w-48 h-48 mb-3 rounded-full shadow-lg"
          src={get_sprite_by_name(@pokemon.sprites, "front_default")}
          alt={@pokemon.name}
        />
        <h5 class="mb-1 text-xl font-medium text-zinc-900">
          <%= String.capitalize(@pokemon.name) %>
          <span class="text-sm text-zinc-500">(#<%= @pokemon.number %>)</span>
        </h5>
        <p class="text-sm text-zinc-500">
          <span class="text-red-500">♥</span> <%= @pokemon.hp %> |
          <span class="text-blue-500">⚔</span> <%= @pokemon.attack %> |
          <span class="text-green-500">🛡</span> <%= @pokemon.defense %> |
          <span class="text-yellow-500">⚡</span> <%= @pokemon.speed %>
        </p>
        <ul class="mt-2 flex flex-col">
          <li :for={type <- @pokemon.types} key={type}>
            <.type_badge type={type} />
          </li>
        </ul>
        <div class="flex mt-4 md:mt-6 space-x-2">
          <.button
            :if={@pokemon.number > min_number()}
            type="button"
            phx-click="previous"
            phx-value-number={@pokemon.number}
          >
            <.icon name="hero-arrow-left" class="w-5 h-5 rtl:rotate-180" />
            <span>Previous</span>
          </.button>

          <.button
            :if={@pokemon.number < max_number()}
            type="button"
            phx-click="next"
            phx-value-number={@pokemon.number}
          >
            <span>Next</span>
            <.icon name="hero-arrow-right" class="w-5 h-5 rtl:rotate-180" />
          </.button>
        </div>
      </div>
    </div>
    """
  end

  defp get_sprite_by_name(sprites, name) do
    case Enum.find(sprites, &(elem(&1, 0) == name)) do
      nil -> ""
      {_, url} -> url
    end
  end

  defp min_number, do: @min_number
  defp max_number, do: @max_number
end
