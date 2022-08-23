defmodule Lebotski.Users.UserTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Users.User

  describe "validations" do
    test "valid user is valid" do
      changeset = User.changeset(%User{}, params_for(:user))

      assert changeset.valid?
    end

    test "external_id is required" do
      changeset = User.changeset(%User{}, Map.merge(params_for(:user), %{external_id: ""}))

      refute changeset.valid?

      assert changeset.errors[:external_id] ==
               {"can't be blank", [validation: :required]}
    end

    test "platform is required" do
      changeset = User.changeset(%User{}, Map.merge(params_for(:user), %{platform: ""}))

      refute changeset.valid?

      assert changeset.errors[:platform] ==
               {"can't be blank", [validation: :required]}
    end

    test "platform is supported" do
      changeset = User.changeset(%User{}, Map.merge(params_for(:user), %{platform: :blah}))

      refute changeset.valid?

      assert elem(changeset.errors[:platform], 0) == "is invalid"
    end
  end
end
