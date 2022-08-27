defmodule Lebotski.Users.User do
  @moduledoc """
  Schema that represents a user within our system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lebotski.Platform

  @type t :: %__MODULE__{
          external_id: String.t(),
          platform: Lebotski.Platform.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "users" do
    field :external_id, :string
    field :platform, Ecto.Enum, values: Platform.supported()

    has_many :teammates, Lebotski.Teams.Teammate

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:platform, :external_id])
    |> validate_required([:platform, :external_id])
  end
end
