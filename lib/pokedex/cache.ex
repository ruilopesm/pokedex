defmodule Pokedex.Cache do
  @moduledoc false
  use Nebulex.Cache, otp_app: :pokedex, adapter: Nebulex.Adapters.Local
end
