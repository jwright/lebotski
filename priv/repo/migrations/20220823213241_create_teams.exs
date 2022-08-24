defmodule Lebotski.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :platform, :string
      add :external_id, :string

      timestamps()
    end
  end
end
