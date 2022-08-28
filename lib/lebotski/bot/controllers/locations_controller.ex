defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Lebotski.{Categories, Locations, Teams}

  alias Lebotski.Bot.Templates.{
    MissingLocationTemplate,
    SearchingErrorTemplate,
    SearchingLocationsTemplate,
    SearchResultsTemplate
  }

  def bowling_alleys(context), do: send_location_response(context, Categories.bowling_alley())

  def cocktail_bars(context), do: send_location_response(context, Categories.cocktail_bar())

  def pharmacies(context), do: send_location_response(context, Categories.pharmacy())

  defp send_location_response(context, category) do
    case find_or_create_location_for_teammate(context) do
      {:ok, context, nil} -> send_missing_location_response(context)
      {:ok, context, location} -> start_location_response(context, category, location)
      {:error, context, nil} -> send_missing_location_response(context)
      _ -> send_error_response(context, "Something went wrong. Try again.")
    end
  end

  defp find_or_create_location_for_teammate(
         %{request: %{params: params, platform: platform}} = context
       ) do
    with {:ok, team, _user, teammate} <-
           Teams.find_or_create_team_with_teammate(platform, params["team_id"], params["user_id"]),
         {:ok, location} <-
           Locations.find_or_create_last_location(params["text"], teammate) do
      context = context |> Map.put(:team, team)
      {:ok, context, location}
    else
      _ -> {:error, context, nil}
    end
  end

  defp controller_response(context, elem \\ :ok), do: {elem, context}

  defp image_url(%{request: request}, image_path) do
    request
    |> Juvet.Router.Request.base_url()
    |> URI.parse()
    |> URI.merge("/images/#{image_path}")
    |> to_string()
  end

  defp send_error_response(%{request: %{params: params}} = context, error) do
    send_response(
      params["response_url"],
      SearchingErrorTemplate.to_message(%{command: params["command"], error: error})
    )

    {:ok, context}
  end

  defp send_missing_location_response(%{request: %{params: params}} = context) do
    context
    |> send_response(
      MissingLocationTemplate.to_message(%{
        command: params["command"],
        image_url: image_url(context, "missing_location.webp")
      })
    )
    |> controller_response()
  end

  defp send_search_results_response(context, category, location) do
    case Locations.search(location, category: category.name) do
      {:ok, %{"error" => %{"description" => error}}} -> send_error_response(context, error)
      {:ok, results} -> send_search_results(context, category, location, results)
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
         context,
         category,
         %{address: address} = location
       ) do
    context
    |> send_response(
      SearchingLocationsTemplate.to_message(%{
        term: category.description,
        location: address
      })
    )
    |> send_search_results_response(category, location)
    |> controller_response()
  end
end
