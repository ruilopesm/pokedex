defmodule Pokedex.Services.PokeAPITest do
  @moduledoc false
  use ExUnit.Case

  alias Pokedex.Services.PokeAPI

  test "get_pokemon/1 returns a Pokemon when the request is successful" do
    {:ok, pokemon} = PokeAPI.get_pokemon("pikachu")

    assert pokemon.name == "pikachu"
    assert pokemon.number == 25
    assert pokemon.types == ["electric"]
  end

  test "get_pokemon/1 returns an error when the Pokemon is not found" do
    {:error, %{reason: reason}} = PokeAPI.get_pokemon("rui")

    assert reason == "Pokemon with name or number 'rui' not found."
  end

  test "get_pokemon/1 when passing a number" do
    {:ok, pokemon} = PokeAPI.get_pokemon(25)

    assert pokemon.name == "pikachu"
    assert pokemon.number == 25
    assert pokemon.types == ["electric"]
  end
end
