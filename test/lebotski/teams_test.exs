defmodule Lebotski.TeamsTest do
  use Lebotski.DataCase, async: true

  import Lebotski.Factory

  alias Lebotski.Teams
  alias Lebotski.Teams.Team

  describe "change_team/1" do
    setup do
      [team: insert(:team)]
    end

    test "returns a team changeset", %{team: team} do
      assert %Ecto.Changeset{} = Teams.change_team(team)
    end
  end

  describe "count_teams/0" do
    setup do
      insert(:team)
      insert(:team)
      :ok
    end

    test "returns the total count of teams" do
      assert Teams.count_teams() == 2
    end
  end

  describe "delete_team/1" do
    setup do
      [team: insert(:team)]
    end

    test "deletes the team", %{team: team} do
      assert {:ok, %Team{}} = Teams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_team!(team.id) end
    end
  end

  describe "create_team/1" do
    test "with valid data creates a team" do
      params = params_for(:team)

      assert {:ok, %Team{} = team} = Teams.create_team(params)
      assert team.external_id == params.external_id
      assert team.platform == :slack
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(params_for(:team, external_id: ""))
    end
  end

  describe "get_team!/1" do
    setup do
      [team: insert(:team)]
    end

    test "returns the team with given id", %{team: team} do
      assert Teams.get_team!(team.id) == team
    end
  end

  describe "list_teams/0" do
    setup do
      [team: insert(:team)]
    end

    test "returns all teams", %{team: team} do
      assert Teams.list_teams() == [team]
    end
  end

  describe "update_team/2" do
    setup do
      [team: insert(:team)]
    end

    test "with valid data updates the team", %{team: team} do
      update_attrs = %{external_id: "some updated external_id"}

      assert {:ok, %Team{} = team} = Teams.update_team(team, update_attrs)
      assert team.external_id == "some updated external_id"
    end

    test "with invalid data returns error changeset", %{team: team} do
      assert {:error, %Ecto.Changeset{}} =
               Teams.update_team(team, params_for(:team, platform: :blah))

      assert team == Teams.get_team!(team.id)
    end
  end
end
