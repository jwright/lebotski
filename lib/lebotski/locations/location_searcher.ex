defmodule Lebotski.Locations.LocationSearcher do
  alias Lebotski.Locations.Location

  @result_limit "10"

  def search(%Location{} = location, opts \\ []),
    do: client().search(search_options(location, opts))

  defp categories(category: category), do: [category]
  defp categories(_), do: []

  defp client, do: YelpEx.Client

  defp latitude(%Location{latitude: latitude}) when not is_nil(latitude), do: latitude
  defp latitude(_), do: nil

  defp location(%Location{address: address}), do: address
  defp location(_), do: nil

  defp longitude(%Location{longitude: longitude}) when not is_nil(longitude), do: longitude
  defp longitude(_), do: nil

  defp limit(%{limit: limit}), do: limit
  defp limit(_), do: System.get_env("RESULT_LIMIT", @result_limit) |> Integer.parse() |> elem(0)

  defp search_options(location, options) do
    [
      params: [
        categories: categories(options) |> Enum.join(","),
        latitude: latitude(location),
        location: location(location),
        longitude: longitude(location),
        limit: limit(options)
      ]
    ]
  end
end
