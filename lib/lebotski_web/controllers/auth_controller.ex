defmodule LebotskiWeb.AuthController do
  use LebotskiWeb, :controller

  alias LebotskiWeb.OAuth

  def request(conn, %{"provider" => provider}),
    do: redirect(conn, external: authorize_url!(provider))

  defp authorize_url!("slack"),
    do: OAuth.Slack.authorize_url!(scope: ["commands"] |> Enum.join(","))
end
