defmodule Lebotski.Bot.Templates.SearchingLocationsTemplate do
  def to_message(_params \\ %{}) do
    %{
      text: "Calculating..."
    }
  end
end
