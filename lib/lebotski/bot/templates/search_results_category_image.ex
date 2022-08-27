defmodule Lebotski.Bot.Templates.SearchResultsCategoryImage do
  alias Lebotski.Categories.Category

  def to_message(%Category{term: :bowling_alley}) do
    %{
      type: "image",
      image_url:
        "https://dangerousminds.net/content/uploads/images/made/content/uploads/images/JeffBridges_TBLsdfsdfsdf_465_291_int.jpg",
      alt_text: "Doo, doo, doo, looking out that backdoor."
    }
  end

  def to_message(%Category{term: :cocktail_bar}) do
    %{
      type: "image",
      image_url:
        "https://dangerousminds.net/content/uploads/images/made/content/uploads/images/JeffBridges_TBLsdfsdfsdf_465_291_int.jpg",
      alt_text: "Doo, doo, doo, looking out that backdoor."
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
