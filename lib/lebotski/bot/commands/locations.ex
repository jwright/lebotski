defmodule Lebotski.Bot.Commands.Locations do
  @moduledoc false

  def bowling_alleys, do: command("not-nam")
  def pharmacies, do: command("what-day-is-this")

  defp command(command), do: "/#{command}"
end
