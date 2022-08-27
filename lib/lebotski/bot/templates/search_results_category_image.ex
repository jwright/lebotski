defmodule Lebotski.Bot.Templates.SearchResultsCategoryImage do
  alias Lebotski.Categories.Category

  def to_message(%Category{term: :bowling_alley}) do
    %{
      type: "image",
      image_url: "https://i.ytimg.com/vi/dQctpzuXmUs/maxresdefault.jpg",
      alt_text: "This is not 'Nam. This is bowling. There are rules.'"
    }
  end

  def to_message(%Category{term: :cocktail_bar}) do
    %{
      type: "image",
      image_url:
        "https://focusmicrositesprod.s3.amazonaws.com/assets/uploads/post_marquee_5f19f76b2870d.jpg",
      alt_text: "Hey, careful man. There's a beverage here!"
    }
  end

  def to_message(%Category{term: :pharmacy}) do
    %{
      type: "image",
      image_url:
        "https://dangerousminds.net/content/uploads/images/made/content/uploads/images/JeffBridges_TBLsdfsdfsdf_465_291_int.jpg",
      alt_text: "Doo, doo, doo, looking out that backdoor."
    }
  end

  def to_message(_) do
    %{
      type: "image",
      image_url:
        "https://dangerousminds.net/content/uploads/images/made/content/uploads/images/JeffBridges_TBLsdfsdfsdf_465_291_int.jpg",
      alt_text: "Doo, doo, doo, looking out that backdoor."
    }
  end
end
