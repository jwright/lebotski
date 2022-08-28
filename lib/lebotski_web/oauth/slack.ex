defmodule LebotskiWeb.OAuth.Slack do
  @moduledoc """
  Slack API client wrapper using `OAuth2.Strategy`/

  This will be extracted into Juvet.
  """

  use OAuth2.Strategy

  alias OAuth2.Strategy

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def client do
    Application.get_env(:lebotski, Slack)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def get_token!(params \\ []) do
    client()
    |> OAuth2.Client.get_token!(Keyword.merge(params, client_secret: client().client_secret))
  end

  # Strategy callbacks

  def authorize_url(client, params) do
    Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> Strategy.AuthCode.get_token(params, headers)
  end

  # Private API

  defp config do
    [
      strategy: __MODULE__,
      site: "https://slack.com/api",
      authorize_url: "https://slack.com/oauth/v2/authorize",
      token_url: "/oauth.v2.access"
    ]
  end
end
