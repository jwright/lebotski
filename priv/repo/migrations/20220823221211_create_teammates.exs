defmodule Lebotski.Repo.Migrations.CreateTeammates do
  use Ecto.Migration

  def change do
    create table(:teammates) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:teammates, [:user_id])
    create index(:teammates, [:team_id])
  end
end
