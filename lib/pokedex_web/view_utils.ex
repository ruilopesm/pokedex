defmodule PokedexWeb.ViewUtils do
  @moduledoc """
  Collection of utility functions to be used throughout the views.
  """

  alias Timex.Format.DateTime.Formatters.Relative

  @doc """
  Formats a datetime to a relative string.

  ## Examples

      iex> relative_datetime(Timex.today() |> Timex.shift(years: -3))
      "3 years ago"

      iex> relative_datetime(Timex.today() |> Timex.shift(years: 3))
      "in 3 years"

      iex> relative_datetime(Timex.today() |> Timex.shift(months: -8))
      "8 months ago"

      iex> relative_datetime(Timex.today() |> Timex.shift(months: 8))
      "in 8 months"

      iex> relative_datetime(Timex.today() |> Timex.shift(days: -1))
      "yesterday"

  """
  @spec relative_datetime(DateTime.t()) :: String.t()
  def relative_datetime(datetime) do
    Relative.lformat!(datetime, "{relative}", "en")
  end
end
