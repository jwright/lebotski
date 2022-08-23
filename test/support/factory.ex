defmodule Lebotski.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Lebotski.Repo

  use Lebotski.Teams.TeamFactory
  use Lebotski.Users.UserFactory
end
