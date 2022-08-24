defmodule Lebotski.Teams.TeammateTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Teams.Teammate

  describe "validations" do
    test "valid teammate is valid" do
      changeset =
        Teammate.changeset(%Teammate{}, %{team_id: insert(:team).id, user_id: insert(:user).id})

      assert changeset.valid?
    end

    test "user id is required" do
      changeset =
        Teammate.changeset(%Teammate{}, Map.merge(params_for(:teammate), %{user_id: nil}))

      refute changeset.valid?

      assert changeset.errors[:user_id] ==
               {"can't be blank", [validation: :required]}
    end

    test "team id is required" do
      changeset =
        Teammate.changeset(%Teammate{}, Map.merge(params_for(:teammate), %{team_id: nil}))

      refute changeset.valid?

      assert changeset.errors[:team_id] ==
               {"can't be blank", [validation: :required]}
    end
  end
end
