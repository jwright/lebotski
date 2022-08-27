defmodule Lebotski.Locations.Location do
  @moduledoc """
  Schema that represents a location saved by a `Teammate`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lebotski.Teams.Teammate

  @type t :: %__MODULE__{
          address: String.t(),
          latitude: float() | nil,
          longitude: float() | nil,
          teammate: Teammate.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "locations" do
    field :address, :string
    field :latitude, :float
    field :longitude, :float
    belongs_to :teammate, Teammate

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:address, :latitude, :longitude, :teammate_id])
    |> cast_assoc(:teammate)
    |> validate_required([:address, :teammate_id])
  end

  def preloads, do: [{:teammate, Teammate.preloads()}]
end
