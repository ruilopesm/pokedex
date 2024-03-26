defmodule Pokedex.Services.PokeAPI do
  @moduledoc false
  use Nebulex.Caching

  alias Pokedex.Cache, as: Cache
  alias Pokedex.Models.Pokemon

  @url "https://pokeapi.co/api/v2/"
  @ttl Application.compile_env!(:pokedex, Pokedex.Cache)[:ttl]

  @type name_or_number :: String.t() | integer()
  @type response :: {:ok, %Pokemon{}} | {:error, %{reason: String.t()}}

  @doc """
  Fetches a Pokemon from the [PokeAPI](#{@url}) by its name or number.
  """
  @spec get_pokemon(name_or_number) :: response
  @decorate cacheable(cache: Cache, key: {Pokemon, name_or_number}, opts: [ttl: @ttl])
  def get_pokemon(name_or_number) do
    url = @url <> "pokemon/#{name_or_number}"
    response = Req.get!(url)

    case response.status do
      200 ->
        {:ok, build_pokemon(response.body)}

      404 ->
        {:error, %{reason: "Pokemon with name or number '#{name_or_number}' not found."}}

      _ ->
        {:error, %{reason: "An error occurred while fetching the Pokemon."}}
    end
  end

  defp build_pokemon(response) do
    %Pokemon{
      name: response["name"],
      number: response["id"],
      hp: build_stat(response["stats"], "hp"),
      attack: build_stat(response["stats"], "attack"),
      defense: build_stat(response["stats"], "defense"),
      speed: build_stat(response["stats"], "speed"),
      types: build_types(response["types"]),
      sprites: build_sprites(response["sprites"])
    }
  end

  defp build_stat(stats, name) do
    Enum.find(stats, fn stat -> stat["stat"]["name"] == name end)
    |> then(& &1["base_stat"])
  end

  defp build_types(types), do: Enum.map(types, & &1["type"]["name"])

  defp build_sprites(sprites) do
    Enum.filter(sprites, fn {k, v} -> k not in ["other", "versions"] and not is_nil(v) end)
  end
end
