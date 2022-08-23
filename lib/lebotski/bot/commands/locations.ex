defmodule Lebotski.Bot.Commands.Locations do
  @moduledoc false

  def pharmacies, do: command("abide")

  defp command(command), do: "/#{command}"
end
