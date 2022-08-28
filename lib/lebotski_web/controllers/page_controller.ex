defmodule LebotskiWeb.PageController do
  use LebotskiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html",
      slack_client_id: System.get_env("SLACK_CLIENT_ID"),
      slack_scopes: ["commands"] |> Enum.join(",")
    )
  end
end
