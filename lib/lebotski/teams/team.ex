defmodule Lebotski.Teams.Team do
  @moduledoc """
  Schema that represents a collection of `User`s within our system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lebotski.Platform

  @type t :: %__MODULE__{
          external_id: String.t(),
          access_token: String.t() | nil,
          platform: Lebotski.Platform.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

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
