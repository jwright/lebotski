defmodule Lebotski.Bot.Router do
  use Juvet.Router

  alias Lebotski.Bot.Commands

  platform :slack do
    command(Commands.Locations.bowling_alleys(),
      to: "lebotski.bot.controllers.locations#bowling_alleys"
    )

    command(Commands.Locations.pharmacies(), to: "lebotski.bot.controllers.locations#pharmacies")
  end
end
