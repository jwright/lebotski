defmodule Lebotski.Locations.LocationSearcherBehavior do
  alias Lebotski.Locations.Location

  @callback search(Location.t(), list()) :: {:ok, map()} | {:error, any()}
end
