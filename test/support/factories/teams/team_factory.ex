defmodule Lebotski.Teams.TeamFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Lebotski.Teams.Team

      def team_factory(attrs) do
        team = %Team{
          platform: :slack,
          external_id: Faker.String.base64(5)
        }

        merge_attributes(team, attrs)
      end
    end
  end
end
