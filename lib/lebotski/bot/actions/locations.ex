defmodule Lebotski.Bot.Actions.Locations do
  @moduledoc false

  @namespace "locations"

  def more_info, do: action("more_info")

  defp action(action), do: "#{namespace()}.#{action}"
  defp namespace, do: @namespace
end
