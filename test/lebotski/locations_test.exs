defmodule Lebotski.LocationsTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Locations
  alias Lebotski.Locations.Location

  describe "change_location/1" do
    setup do
      [location: insert(:location)]
    end

    test "returns a location changeset", %{location: location} do
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end

  describe "count_locations/0" do
    setup do
      insert(:location)
      insert(:location)
      :ok
    end

    test "returns the total count of locations" do
      assert Locations.count_locations() == 2
    end
  end

  describe "delete_location/1" do
    setup do
      [location: insert(:location)]
    end

    test "deletes the location", %{location: location} do
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end
  end

  describe "create_location/1" do
    test "with valid data creates a location" do
      teammate = insert(:teammate)
      params = params_for(:location, teammate: teammate)

      assert {:ok, %Location{} = location} = Locations.create_location(params)
      assert location.address
      assert location.teammate_id == teammate.id
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Locations.create_location(params_for(:location, address: ""))
    end
  end

  describe "get_location!/1" do
    setup do
      [location: insert(:location)]
    end

    test "returns the location with given id", %{location: location} do
      assert Locations.get_location!(location.id) == location
    end
  end

  describe "list_locations/0" do
    setup do
      [location: insert(:location)]
    end

    test "returns all locations", %{location: location} do
      assert Locations.list_locations() == [location]
    end
  end

  describe "update_location/2" do
    setup do
      [location: insert(:location)]
    end

    test "with valid data updates the location", %{location: location} do
      update_attrs = %{address: "some updated address"}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.address == "some updated address"
    end

    test "with invalid data returns error changeset", %{location: location} do
      assert {:error, %Ecto.Changeset{}} =
               Locations.update_location(location, params_for(:location, address: ""))

      assert location == Locations.get_location!(location.id)
    end
  end
end
