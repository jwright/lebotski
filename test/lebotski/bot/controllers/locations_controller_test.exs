defmodule Lebotski.Bot.Controllers.LocationsControllerTest do
  use LebotskiWeb.ConnCase, async: true

  alias Lebotski.{Locations, Repo, Teams, Users}
  alias Lebotski.Bot.Controllers.LocationsController

  def location_count, do: Locations.count_locations()
  def team_count, do: Teams.count_teams()
  def teammate_count, do: Teams.count_teammates()
  def user_count, do: Users.count_users()

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

    test "creates a teammate", %{context: context} do
      previous_teammate_count = teammate_count()

      assert {:ok, _context} = LocationsController.pharmacies(context)
      assert previous_teammate_count + 1 == teammate_count()

      teammate =
        Teams.Teammate
        |> Ecto.Query.last()
        |> Repo.one()

      team =
        Teams.Team
        |> Ecto.Query.last()
        |> Repo.one()

      user =
        Users.User
        |> Ecto.Query.last()
        |> Repo.one()

      assert teammate.team_id == team.id
      assert teammate.user_id == user.id
    end

    test "inserts the location for the teammate", %{context: context} do
      previous_location_count = location_count()

      assert {:ok, _context} = LocationsController.pharmacies(context)
      assert previous_location_count + 1 == location_count()
    end
  end
end
