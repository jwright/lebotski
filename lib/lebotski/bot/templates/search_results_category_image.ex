defmodule Lebotski.Bot.Templates.SearchResultsCategoryImage do
  alias Lebotski.Categories
  alias Lebotski.Categories.Category

  def to_message(base_image_url, %Category{term: term}) do
    %{
      type: "image",
      image_url: image_url(base_image_url, term),
      alt_text: alt_text(term)
    }
  end

  def to_message(base_image_url, _), do: to_message(base_image_url, Categories.pharmacy())

  defp alt_text(:bowling_alley), do: "This is not 'Nam. This is bowling. There are rules."
  defp alt_text(:cocktail_bar), do: "Hey, careful man. There's a beverage here!"
  defp alt_text(:pharmacy), do: "Doo, doo, doo, looking out that backdoor."

  defp image_url(base_image_url, category) do
    base_image_url
    |> URI.parse()
    |> URI.merge("#{category}.jpg")
    |> to_string()
  end
end
