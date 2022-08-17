defmodule Lebotski.Repo do
  use Ecto.Repo,
    otp_app: :lebotski,
    adapter: Ecto.Adapters.Postgres
end
