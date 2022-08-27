defmodule Lebotski.Categories do
  defmodule Category do
    @enforce_keys [:description, :name]
    defstruct [:description, :name]

    def new(name, description) do
      %__MODULE__{
        description: description,
        name: name
      }
    end
  end

  def bowling_alley(), do: Category.new("bowling", "Bowling Alleys")
  def cocktail_bar(), do: Category.new("cocktailbars", "Cocktail Bars")
  def pharmacy(), do: Category.new("cannabisdispensaries", "Cannabis Dispensaries")
end
