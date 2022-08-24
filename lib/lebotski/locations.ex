defmodule Lebotski.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias Lebotski.Repo

  alias Lebotski.Locations.Location

  @doc """
  Returns the total number of locations.

  ## Examples

      iex> count_locations()
      239

  """
  def count_locations do
    Repo.aggregate(Location, :count, :id)
  end

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Location
    |> Repo.all()
    |> Repo.preload(Location.preloads())
  end

  @doc """
  Finds or creates a `Location` based on the `address` provided. If there is an address provided,
  then a new Location is created for the specified `teammate`, else the last known location is returned.

  ## Examples

      iex> find_or_create_last_location("123 Main St.", %Teammate{id: 123})
      {:ok, %Location{id: 1234, teammate_id: 123, address: "123 Main St."}}

      iex> find_or_create_last_location(nil, teammate)
      {:ok, nil}

  """
  def find_or_create_last_location(address, teammate) do
    case address do
      nil -> {:ok, find_last_location(teammate)}
      address -> create_location(%{address: address, teammate_id: teammate.id})
    end
  end

  @doc """
  Finds the last known address provided for the `teammate`.

  ## Examples

      iex> find_last_location(%Teammate{id: 123})
      %Location{id: 1234, teammate_id: 123, address: "123 Main St."}

      iex> find_last_location(teammate)
      nil

  """
  def find_last_location(%{id: teammate_id}) do
    Location
    |> where([l], l.teammate_id == ^teammate_id)
    |> last(:inserted_at)
    |> Repo.one()
    |> Repo.preload(Location.preloads())
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id) |> Repo.preload(Location.preloads())

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end
end
