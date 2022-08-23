defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  def pharmacies(%{request: %{params: params}} = context) do
    IO.inspect(params)
    IO.puts("You called?")

    {:ok, context}
  end
end
