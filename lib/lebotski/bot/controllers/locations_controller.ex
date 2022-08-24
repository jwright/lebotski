defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Locations, Teams}
  alias Lebotski.Bot.Templates.MissingLocationTemplate

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

  defp controller_response(context, elem \\ :ok), do: {elem, context}

  defp send_error_response(context) do
    context = send_response(context, %{text: "Some error occured!"})

    {:ok, context}
  end

  defp send_missing_location_response(context) do
    context
    |> send_response(MissingLocationTemplate.to_message())
    |> controller_response()
  end

  defp start_location_response(_location, context) do
    context = send_response(context, %{text: "Calculating..."})

    {:ok, context}
  end
end
