defmodule Lebotski.Bot.Router do
  use Juvet.Router

  alias Lebotski.Bot.Commands

  platform :slack do
    command(Commands.Locations.pharmacies(), to: "lebotski.bot.controllers.locations#pharmacies")
  end
end
