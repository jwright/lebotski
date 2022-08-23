defmodule Lebotski.UsersTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Users
  alias Lebotski.Users.User

  describe "list_users/0" do
    setup do
      [user: insert(:user)]
    end

    test "returns all users", %{user: user} do
      assert Users.list_users() == [user]
    end
  end

  describe "get_user!/1" do
    setup do
      [user: insert(:user)]
    end

    test "returns the user with given id", %{user: user} do
      assert Users.get_user!(user.id) == user
    end
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      params = params_for(:user)

      assert {:ok, %User{} = user} = Users.create_user(params)
      assert user.external_id == params.external_id
      assert user.platform == :slack
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(params_for(:user, external_id: ""))
    end
  end

  describe "update_user/2" do
    setup do
      [user: insert(:user)]
    end

    test "with valid data updates the user", %{user: user} do
      update_attrs = %{external_id: "some updated external_id"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.external_id == "some updated external_id"
    end

    test "with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} =
               Users.update_user(user, params_for(:user, platform: :blah))

      assert user == Users.get_user!(user.id)
    end
  end

  describe "delete_user/1" do
    setup do
      [user: insert(:user)]
    end

    test "deletes the user", %{user: user} do
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end
  end

  describe "change_user/1" do
    setup do
      [user: insert(:user)]
    end

    test "returns a user changeset", %{user: user} do
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
