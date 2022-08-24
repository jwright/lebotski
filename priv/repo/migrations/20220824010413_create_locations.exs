defmodule Lebotski.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :address, :string
      add :latitude, :float
      add :longitude, :float
      add :teammate_id, references(:teammates, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:teammate_id])
  end
end
