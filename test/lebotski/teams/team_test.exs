defmodule Lebotski.Teams.TeamTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Teams.Team

  describe "validations" do
    test "valid team is valid" do
      changeset = Team.changeset(%Team{}, params_for(:team))

      assert changeset.valid?
    end

    test "external_id is required" do
      changeset = Team.changeset(%Team{}, Map.merge(params_for(:team), %{external_id: ""}))

      refute changeset.valid?

      assert changeset.errors[:external_id] ==
               {"can't be blank", [validation: :required]}
    end

    test "platform is required" do
      changeset = Team.changeset(%Team{}, Map.merge(params_for(:team), %{platform: ""}))

      refute changeset.valid?

      assert changeset.errors[:platform] ==
               {"can't be blank", [validation: :required]}
    end

    test "platform is supported" do
      changeset = Team.changeset(%Team{}, Map.merge(params_for(:team), %{platform: :blah}))

      refute changeset.valid?

      assert elem(changeset.errors[:platform], 0) == "is invalid"
    end
  end
end
