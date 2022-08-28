defmodule LebotskiWeb.AuthController do
  use LebotskiWeb, :controller

  alias Lebotski.Teams
  alias LebotskiWeb.OAuth

  def callback(conn, %{"provider" => provider, "code" => code}) do
    %{token: token} = get_token!(provider, code)

    case find_or_create_account_from_access_token(provider, token) do
      {:ok, _team, _user, _teammate} -> render(conn, "success.html")
      {:error, error} -> render(conn, "error.html", error: error, provider: provider)
    end
  end

  def request(conn, %{"provider" => provider}),
    do: redirect(conn, external: authorize_url!(provider))

  defp authorize_url!("slack"),
    do: OAuth.Slack.authorize_url!(scope: ["commands"] |> Enum.join(","))

  defp find_or_create_account_from_access_token("slack", %{other_params: other_params} = token) do
    case other_params["ok"] do
      false -> {:error, other_params["error"]}
      true -> find_or_create_account("slack", token)
    end
  end

  defp find_or_create_account("slack", %{access_token: access_token, other_params: other_params}) do
    team_id = other_params |> get_in(["team", "id"])
    user_id = other_params |> get_in(["authed_user", "id"])

    case Teams.find_or_create_team_with_teammate(:slack, team_id, user_id) do
      {:error, changeset} ->
        {:error, "Could not save account"}

      {:ok, team, user, teammate} ->
        {:ok, team} = Teams.update_team(team, %{access_token: access_token})
        {:ok, team, user, teammate}
    end
  end

  defp get_token!("slack", code), do: OAuth.Slack.get_token!(code: code)
end
