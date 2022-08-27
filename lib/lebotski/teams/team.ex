defmodule Lebotski.Teams.Team do
  @moduledoc """
  Schema that represents a collection of `User`s within our system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lebotski.Platform

  schema "teams" do
    field :access_token, :string
    field :external_id, :string
    field :platform, Ecto.Enum, values: Platform.supported()

    has_many :teammates, Lebotski.Teams.Teammate

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:platform, :access_token, :external_id])
    |> validate_required([:platform, :external_id])
  end
end
