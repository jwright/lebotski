defmodule Lebotski.Bot.Commands.Locations do
  @moduledoc false

  def bowling_alley, do: command("not-nam")
  def pharmacy, do: command("what-day-is-this")

  defp command(command), do: "/#{command}"
end
