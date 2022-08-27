defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Categories, Locations, Teams}

  alias Lebotski.Bot.Templates.{
    MissingLocationTemplate,
    SearchingErrorTemplate,
    SearchingLocationsTemplate,
    SearchResultsTemplate
  }

  def pharmacies(%{request: %{params: params, platform: platform}} = context) do
    with {:ok, team, _user, teammate} <-
           Teams.find_or_create_team_with_teammate(platform, params["team_id"], params["user_id"]),
         {:ok, location} <-
           Locations.find_or_create_last_location(params["text"], teammate) do
      context = context |> Map.put(:team, team)

      case location do
        nil -> send_missing_location_response(context)
        location -> start_location_response(location, context)
      end
    else
      _ -> send_error_response(context, "Something went wrong. Try again.")
    end
  end

  defp controller_response(context, elem \\ :ok), do: {elem, context}

  defp send_error_response(%{request: %{params: params}} = context, error) do
    send_response(
      params["response_url"],
      SearchingErrorTemplate.to_message(%{command: params["command"], error: error})
    )

    {:ok, context}
  end

  defp send_missing_location_response(%{request: %{params: params}} = context) do
    context
    |> send_response(MissingLocationTemplate.to_message(%{command: params["command"]}))
    |> controller_response()
  end

  defp send_search_results_response(context, category, location) do
    case Locations.search(location, category: category.name) do
      {:ok, %{"error" => %{"description" => error}}} -> send_error_response(context, error)
      {:ok, results} -> send_search_results(context, category.description, location, results)
      {:error, error} -> send_error_response(context, error)
    end

    context
  end

  defp send_search_results(
         %{request: %{params: params}},
         category,
         location,
         results
       ) do
    send_response(
      params["response_url"],
      SearchResultsTemplate.to_message(%{category: category, location: location, results: results})
    )
  end

  defp start_location_response(
         %{address: address} = location,
         context
       ) do
    context
    |> send_response(
      SearchingLocationsTemplate.to_message(%{
        term: Categories.pharmacy().description,
        location: address
      })
    )
    |> send_search_results_response(Categories.pharmacy(), location)
    |> controller_response()
  end
end
