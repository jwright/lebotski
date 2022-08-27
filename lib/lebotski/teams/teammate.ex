defmodule Lebotski.Teams.Teammate do
  @moduledoc """
  Schema that represents a `User` and a `Team` relationship.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          user: Lebotski.Users.User.t(),
          team: Lebotski.Teams.Team.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "teammates" do
    belongs_to :team, Lebotski.Teams.Team
    belongs_to :user, Lebotski.Users.User

    timestamps()
  end

  @doc false
  def changeset(teammate, attrs) do
    teammate
    |> cast(attrs, [:team_id, :user_id])
    |> cast_assoc(:team)
    |> cast_assoc(:user)
    |> validate_required([:team_id, :user_id])
  end

  def preloads, do: [:team, :user]
end
