defmodule Lebotski.Teams.TeammateFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Lebotski.Teams.Teammate

      def teammate_factory(attrs) do
        teammate = %Teammate{
          team: attrs[:team] || build(:team),
          user: attrs[:user] || build(:user)
        }

        merge_attributes(teammate, attrs)
      end
    end
  end
end
