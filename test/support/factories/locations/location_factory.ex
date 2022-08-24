defmodule Lebotski.Locations.LocationFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Lebotski.Locations.Location

      def location_factory(attrs) do
        location = %Location{
          address: "#{Faker.Address.city()}, #{Faker.Address.state_abbr()}",
          teammate: attrs[:teammate] || build(:teammate),
          latitude: Faker.Address.latitude(),
          longitude: Faker.Address.longitude()
        }

        merge_attributes(location, attrs)
      end
    end
  end
end
