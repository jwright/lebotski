defmodule LebotskiWeb.PageControllerTest do
  use LebotskiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ Routes.auth_path(conn, :request, :slack)
  end
end
