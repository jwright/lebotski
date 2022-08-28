defmodule LebotskiWeb.AuthController do
  use LebotskiWeb, :controller

  alias LebotskiWeb.OAuth

  def callback(conn, %{"provider" => provider, "code" => code}) do
    %{token: token} = get_token!(provider, code)

    token |> IO.inspect(label: "token")

    render(conn, "success.html")
  end

  def request(conn, %{"provider" => provider}),
    do: redirect(conn, external: authorize_url!(provider))

  defp authorize_url!("slack"),
    do: OAuth.Slack.authorize_url!(scope: ["commands"] |> Enum.join(","))

  defp get_token!("slack", code), do: OAuth.Slack.get_token!(code: code)
end
