defmodule Lebotski.Bot.Controllers.LocationsControllerTest do
  use LebotskiWeb.ConnCase

  import Lebotski.Factory
  import Mock

  alias Lebotski.{Locations, Repo, Teams, Users}
  alias Lebotski.Bot.Controllers.LocationsController

  def location_count, do: Locations.count_locations()
  def team_count, do: Teams.count_teams()
  def teammate_count, do: Teams.count_teammates()
  def user_count, do: Users.count_users()

  describe "pharmacies/1 with a valid request" do
    setup_with_mocks [
      {Lebotski.Locations.LocationSearcher, [],
       [search: fn _location, _opts -> {:ok, %{"businesses" => [], "total" => 0}} end]},
      {HTTPoison, [], [post!: fn "https://example.com/response_url", _response, _opts -> nil end]}
    ] do
      params = %{
        "team_id" => "T12345",
        "text" => "West Bromwich",
        "user_id" => "U12345",
        "username" => "robert",
        "response_url" => "https://example.com/response_url"
      }

      context = %{
        conn: build_conn(),
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

    test "with an existing team uses that team", %{context: context} do
      expected = insert(:team, external_id: context.request.params["team_id"])

      previous_team_count = team_count()

      assert {:ok, _context} = LocationsController.pharmacies(context)
      assert previous_team_count == team_count()

      actual =
        Teams.Team
        |> Ecto.Query.last()
        |> Repo.one()

      assert expected == actual
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
