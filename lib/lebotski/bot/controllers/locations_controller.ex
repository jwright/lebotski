defmodule Lebotski.Bot.Controllers.LocationsController do
  use Juvet.Controller

  alias Juvet.Router.Response

  def pharmacies(%{request: %{params: params}} = context) do
    context = send_response(context, Response.new(body: %{text: "Gotcha!"}))

    {:ok, context}
  end
end
