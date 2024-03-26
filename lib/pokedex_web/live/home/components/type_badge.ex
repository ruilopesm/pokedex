defmodule PokedexWeb.HomeLive.Components.TypeBadge do
  @moduledoc """
  Component to display a Pokemon's type as a badge.
  """
  use PokedexWeb, :html

  @types ~w(
    normal
    fire
    fighting
    water
    poison
    electric
    ground
    grass
    flying
    ice
    bug
    psychic
    rock
    dragon
    ghost
    dark
    steel
    fairy
  )

  attr :type, :string, required: true

  def type_badge(assigns) do
    ~H"""
    <div class={["text-sm font-bold w-24 text-center inline-block", bg_color(@type)]}>
      <span class="uppercase text-white drop-shadow-md"><%= @type %></span>
    </div>
    """
  end

  # credo:disable-for-next-line Credo.Check.Refactor.CyclomaticComplexity
  defp bg_color(type) when type in @types do
    case type do
      "normal" -> "bg-[#A8A878]"
      "fire" -> "bg-[#F08030]"
      "fighting" -> "bg-[#C03028]"
      "water" -> "bg-[#6890F0]"
      "poison" -> "bg-[#A040A0]"
      "electric" -> "bg-[#F8D030]"
      "ground" -> "bg-[#E0C068]"
      "grass" -> "bg-[#78C850]"
      "flying" -> "bg-[#A890F0]"
      "ice" -> "bg-[#98D8D8]"
      "bug" -> "bg-[#A8B820]"
      "psychic" -> "bg-[#F85888]"
      "rock" -> "bg-[#B8A038]"
      "dragon" -> "bg-[#7038F8]"
      "ghost" -> "bg-[#705898]"
      "dark" -> "bg-[#705848]"
      "steel" -> "bg-[#B8B8D0]"
      "fairy" -> "bg-[#FFB7FA]"
    end
  end
end
