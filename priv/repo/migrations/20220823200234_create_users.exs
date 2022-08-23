defmodule Lebotski.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :platform, :string
      add :external_id, :string

      timestamps()
    end
  end
end
