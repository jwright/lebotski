defmodule Lebotski.Bot.Controllers.LocationsControllerTest do
  use LebotskiWeb.ConnCase, async: true

  alias Lebotski.{Repo, Teams, Users}
  alias Lebotski.Bot.Controllers.LocationsController

  def user_count, do: Users.count_users()
  def team_count, do: Teams.count_teams()

  describe "pharmacies/1 with a valid request" do
    setup %{conn: conn} do
      params = %{
        "team_id" => "T12345",
        "text" => "West Bromwich",
        "user_id" => "U12345",
        "username" => "robert"
      }

      context = %{
        conn: conn,
        request: %{
          params: params,
          platform: :slack
        }
      }

      [context: context]
    end

    test "creates a user", %{context: context} do
      previous_user_count = user_count()

      assert {:ok, _context} = LocationsController.pharmacies(context)
      assert previous_user_count + 1 == user_count()

      user =
        Users.User
        |> Ecto.Query.last()
        |> Repo.one()

      assert user.platform == :slack
      assert user.external_id == "U12345"
    end

    test "creates a team", %{context: context} do
      previous_team_count = team_count()

      assert {:ok, _context} = LocationsController.pharmacies(context)
      assert previous_team_count + 1 == team_count()

      team =
        Teams.Team
        |> Ecto.Query.last()
        |> Repo.one()

      assert team.platform == :slack
      assert team.external_id == "T12345"
    end
  end
end
