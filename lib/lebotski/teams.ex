defmodule Lebotski.Teams do
  @moduledoc """
  The Teams context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias Lebotski.{Repo, Users}
  alias Lebotski.Teams.{Team, Teammate}
  alias Lebotski.Users.User

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teammate changes.

  ## Examples

      iex> change_teammate(teammate)
      %Ecto.Changeset{data: %Teammate{}}

  """
  def change_teammate(%Teammate{} = teammate, attrs \\ %{}) do
    Teammate.changeset(teammate, attrs)
  end

  @doc """
  Returns the total number of teams.

  ## Examples

      iex> count_teams()
      24

  """
  def count_teams do
    Repo.aggregate(Team, :count, :id)
  end

  @doc """
  Returns the total number of teammates.

  ## Examples

      iex> count_teammates()
      3

  """
  def count_teammates do
    Repo.aggregate(Teammate, :count, :id)
  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a teammate.

  ## Examples

      iex> create_teammate(%{field: value})
      {:ok, %Teammate{}}

      iex> create_teammate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teammate(attrs \\ %{}) do
    %Teammate{}
    |> Teammate.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  defp create_user_on_team(user_id, %{id: team_id, platform: platform}) do
    case Multi.new()
         |> Multi.insert(
           :user,
           Users.change_user(%User{platform: platform, external_id: user_id})
         )
         |> Multi.insert(:teammate, fn %{user: user} ->
           change_teammate(%Teammate{user_id: user.id, team_id: team_id})
         end)
         |> Repo.transaction() do
      {:ok, %{user: user, teammate: teammate}} ->
        {:ok, user, teammate}

      {:error, _operation, error, _changes} ->
        {:error, error}
    end
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Deletes a teammate.

  ## Examples

      iex> delete_teammate(teammate)
      {:ok, %Teammate{}}

      iex> delete_teammate(teammate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teammate(%Teammate{} = teammate) do
    Repo.delete(teammate)
  end

  @doc """
  Finds or creates a `Team` with the specified `platform` and
  `external_id`.

  ## Examples

      iex> find_or_create_team(:slack, "T12345")
      {:ok, %Teammate{id: 123. platform: :slack, external_id: "T12345"}}

      iex> find_or_create_team(:slack, "")
      {:error, %Ecto.Changeset{}}

  """
  def find_or_create_team(platform, external_id) do
    params = %{platform: platform, external_id: external_id}

    case get_team_by(params) do
      nil -> create_team(params)
      team -> {:ok, team}
    end
  end

  @doc """
  Finds or creates a `Teammate` with the specified `user_id` and
  `team`.

  ## Examples

      iex> find_or_create_user_on_team("U12345", %{id: 1234, platform: :slack})
      {:ok, %User{id: 123. platform: :slack, external_id: "U12345"}, %Teammate{team_id: 1234, user_id: 123}}

      iex> find_or_create_user_on_team("", team)
      {:error, %Ecto.Changeset{}}

  """
  def find_or_create_user_on_team(user_id, team) do
    case get_teammate_by(user_id, team) do
      nil -> create_user_on_team(user_id, team)
      %{user: user} = teammate -> {:ok, user, teammate}
    end
  end

  @doc """
  Finds or creates both a `Team` and a `User` along with a `Teammate` that links the two based on the
  parameters given for the specified `platform`.

  ## Examples

      iex> find_or_create_team_with_teammate(:slack, "T12345", "U12345")
      {:ok, %Team{id: 1234, platform: :slack, external_id: "T12345"},
        %User{id: 123. platform: :slack, external_id: "U12345"},
        %Teammate{team_id: 1234, user_id: 123}}

      iex> find_or_create_user_on_team("", team)
      {:error, %Ecto.Changeset{}}

  """
  def find_or_create_team_with_teammate(platform, team_id, user_id) do
    with {:ok, team} <- find_or_create_team(platform, team_id),
         {:ok, user, teammate} <-
           find_or_create_user_on_team(user_id, team) do
      {:ok, team, user, teammate}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  def get_team_by(queryable \\ Team, clauses, opts \\ []) do
    queryable
    |> Repo.get_by(clauses, opts)
  end

  def get_teammate_by(queryable \\ Teammate, user_id, %{id: team_id}, opts \\ []) do
    queryable
    |> join(:inner, [tm], u in assoc(tm, :user))
    |> join(:inner, [tm], t in assoc(tm, :team))
    |> where([_tm, u, _t], u.external_id == ^user_id)
    |> where([_tm, _u, t], t.id == ^team_id)
    |> Repo.one(opts)
    |> Repo.preload(Teammate.preloads())
  end

  @doc """
  Gets a single teammate.

  Raises `Ecto.NoResultsError` if the Teammate does not exist.

  ## Examples

      iex> get_teammate!(123)
      %Teammate{}

      iex> get_teammate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teammate!(id), do: Repo.get!(Teammate, id)

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end
end
