defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Locations, Teams}

  def pharmacies(%{request: %{params: params, platform: platform}} = context) do
    with {:ok, _team, _user, teammate} <-
           Teams.find_or_create_team_with_teammate(platform, params["team_id"], params["user_id"]),
         {:ok, _location} <-
           Locations.create_location(%{address: params["text"], teammate_id: teammate.id}) do
      # TODO: Check for an address
      # If no address, check for a last one in the database
      # If there are none, send an error back
      # else send back calculating...
      context = send_response(context, Juvet.Router.Response.new(body: %{text: "Gotcha!"}))
    end

    {:ok, context}
  end
end
