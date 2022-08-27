defmodule Lebotski.Repo.Migrations.AddAccessTokenToTeams do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :access_token, :string
    end
  end
end
