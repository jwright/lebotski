defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Locations, Teams}

  def pharmacies(%{request: %{params: params, platform: platform}} = context) do
    with {:ok, _team, _user, teammate} <-
           Teams.find_or_create_team_with_teammate(platform, params["team_id"], params["user_id"]),
         {:ok, location} <-
           Locations.find_or_create_last_location(params["text"], teammate) do
      case location do
        nil -> send_missing_location_response(context)
        location -> start_location_response(location, context)
      end
    else
      _ -> send_error_response(context)
    end
  end

  defp send_error_response(context), do: {:ok, context}
  defp send_missing_location_response(context), do: {:ok, context}

  defp start_location_response(_location, context) do
    context = send_response(context, Juvet.Router.Response.new(body: %{text: "Calculating..."}))

    {:ok, context}
  end
end
