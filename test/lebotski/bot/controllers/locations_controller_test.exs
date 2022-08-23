defmodule Lebotski.Bot.Controllers.LocationsControllerTest do
  use LebotskiWeb.ConnCase, async: true

  alias Lebotski.{Repo, Users}
  alias Lebotski.Bot.Controllers.LocationsController

  describe "pharmacies/1 with a valid request" do
    setup %{conn: conn} do
      params = %{
        "channel_id" => "C12345",
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
      user_count = Users.count_users()

      assert {:ok, _context} = LocationsController.pharmacies(context)

      new_user_count = Users.count_users()

      assert user_count + 1 == new_user_count

      user =
        Users.User
        |> Ecto.Query.last()
        |> Repo.one()

      assert user.platform == :slack
      assert user.external_id == "U12345"
    end
  end
end
