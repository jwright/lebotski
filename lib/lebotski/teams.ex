defmodule Lebotski.Teams do
  @moduledoc """
  The Teams context.
  """

  import Ecto.Query, warn: false
  alias Lebotski.Repo

  alias Lebotski.Teams.{Team, Teammate}

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
  Returns the total number of teams.

  ## Examples

      iex> count_teams()
      24

  """
  def count_teams do
    Repo.aggregate(Team, :count, :id)
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
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

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
