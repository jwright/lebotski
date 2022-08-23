defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Teams, Users}

  def pharmacies(%{request: %{params: params, platform: platform}} = context) do
    {:ok, user} = Users.create_user(%{external_id: params["user_id"], platform: platform})
    {:ok, team} = Teams.create_team(%{external_id: params["team_id"], platform: platform})
    {:ok, _teammate} = Teams.create_teammate(%{team_id: team.id, user_id: user.id})

    # TODO: Check for an address
    # If no address, check for a last one in the database
    # If there are none, send an error back
    # else send back calculating...
    context = send_response(context, Juvet.Router.Response.new(body: %{text: "Gotcha!"}))

    # Geocode the address
    # Use the weedmaps API to find based on lat/long

    {:ok, context}
  end
end
