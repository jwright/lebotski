defmodule Lebotski.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Lebotski.Repo

  use Lebotski.Users.UserFactory
end
