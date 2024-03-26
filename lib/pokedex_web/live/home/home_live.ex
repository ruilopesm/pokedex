defmodule PokedexWeb.HomeLive do
  use PokedexWeb, :live_view

  alias Pokedex.Models.Pokemon
  alias Pokedex.Services.PokeAPI

  import PokedexWeb.HomeLive.Components.{PokemonCard, PokemonTable}

  @impl true
  def render(assigns) do
    ~H"""
    <section id="content">
      <.form for={@form} phx-submit="search">
        <.input
          phx-mounted={JS.focus()}
          type="search"
          placeholder="Search for a Pokemon..."
          name="search"
          value=""
          required
        />
      </.form>

      <.modal :if={@show_modal} id="pokemon-modal" show on_cancel={JS.push("close-modal")}>
        <div class="flex justify-center items-center">
          <.pokemon_card pokemon={@pokemon} />
        </div>
      </.modal>

      <p class="mt-6 font-normal text-md">Last searches</p>
      <.pokemon_table pokemons={@last_searches} />
    </section>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(form: %{"search" => ""})
     |> assign(:pokemon, %Pokemon{})
     |> assign(:last_searches, [])
     |> assign(:show_modal, false)}
  end

  @impl true
  def handle_event("search", %{"search" => query}, socket) do
    query = String.downcase(query) |> String.trim()

    case PokeAPI.get_pokemon(query) do
      {:ok, %Pokemon{} = pokemon} ->
        {:noreply,
         socket
         |> assign(pokemon: pokemon)
         |> update_last_searches(pokemon)
         |> assign(show_modal: true)}

      {:error, %{reason: reason}} ->
        {:noreply, put_flash(socket, :error, reason)}
    end
  end

  @impl true
  def handle_event(event, %{"number" => number}, socket) when event in ["previous", "next"] do
    new_number =
      if(event == "previous",
        do: String.to_integer(number) - 1,
        else: String.to_integer(number) + 1
      )

    {:ok, %Pokemon{} = pokemon} = PokeAPI.get_pokemon(new_number)

    {:noreply, assign(socket, pokemon: pokemon)}
  end

  @impl true
  def handle_event("show-pokemon", %{"number" => number}, socket) do
    {:ok, %Pokemon{} = pokemon} = PokeAPI.get_pokemon(number)

    {:noreply,
     socket
     |> assign(pokemon: pokemon)
     |> assign(show_modal: true)}
  end

  @impl true
  def handle_event("close-modal", _, socket) do
    {:noreply, assign(socket, show_modal: false)}
  end

  defp update_last_searches(socket, pokemon) do
    now = DateTime.utc_now()
    pokemon = Map.put(pokemon, :searched_at, now)

    update(socket, :last_searches, &[pokemon | &1])
  end
end
