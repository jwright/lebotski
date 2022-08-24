defmodule Lebotski.Locations.Location do
  @moduledoc """
  Schema that represents a location saved by a `Teammate`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :latitude, :float
    field :longitude, :float
    belongs_to :teammate, Lebotski.Teams.Teammate

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:address, :latitude, :longitude, :teammate_id])
    |> cast_assoc(:teammate)
    |> validate_required([:address, :teammate_id])
  end
end
