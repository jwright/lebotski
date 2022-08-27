defmodule Lebotski.Platform do
  @supported [:slack]

  @type platform :: :slack

  def supported, do: @supported
end
