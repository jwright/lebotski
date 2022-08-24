defmodule Lebotski.Locations.LocationTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Locations.Location

  describe "validations" do
    test "valid location is valid" do
      changeset =
        Location.changeset(%Location{}, params_for(:location, teammate: insert(:teammate)))

      assert changeset.valid?
    end

    test "address is required" do
      changeset =
        Location.changeset(%Location{}, Map.merge(params_for(:location), %{address: ""}))

      refute changeset.valid?

      assert changeset.errors[:address] ==
               {"can't be blank", [validation: :required]}
    end

    test "teammate id is required" do
      changeset =
        Location.changeset(%Location{}, Map.merge(params_for(:location), %{teammate_id: nil}))

      refute changeset.valid?

      assert changeset.errors[:teammate_id] ==
               {"can't be blank", [validation: :required]}
    end
  end
end
