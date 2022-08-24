defmodule Lebotski.Users.UserFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Lebotski.Users.User

      def user_factory(attrs) do
        user = %User{
          platform: :slack,
          external_id: Faker.String.base64(5)
        }

        merge_attributes(user, attrs)
      end
    end
  end
end
