defmodule Lebotski.Bot.Router do
  use Juvet.Router

  alias Lebotski.Bot.Commands

  platform :slack do
    command(Commands.Locations.bowling_alley(),
      to: "lebotski.bot.controllers.locations#bowling_alleys"
    )

    command(Commands.Locations.cocktail_bar(),
      to: "lebotski.bot.controllers.locations#cocktail_bars"
    )

    command(Commands.Locations.pharmacy(), to: "lebotski.bot.controllers.locations#pharmacies")
  end
end
