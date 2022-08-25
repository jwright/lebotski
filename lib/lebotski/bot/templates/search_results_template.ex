defmodule Lebotski.Bot.Templates.SearchResultsTemplate do
  def to_message(_params \\ %{}) do
    %{
      text: "Search Results..."
    }
  end
end
