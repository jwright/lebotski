defmodule Lebotski.Users.User do
  @moduledoc """
  Schema that represents a user within our system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Lebotski.Platform

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
