defmodule Lebotski.Bot.Templates.MissingLocationTemplate do
  def to_message(params \\ %{}) do
    %{
      text: "Missing location!"
    }
  end
end
