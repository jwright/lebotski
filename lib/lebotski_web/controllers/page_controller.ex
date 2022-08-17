defmodule LebotskiWeb.PageController do
  use LebotskiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
