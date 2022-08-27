defmodule Lebotski.Categories do
  defmodule Category do
    @enforce_keys [:description, :name, :term]
    defstruct [:description, :name, :term]

    def new(term, name, description) do
      %__MODULE__{
        term: term,
        description: description,
        name: name
      }
    end
  end

  def bowling_alley(), do: Category.new(:bowling_alley, "bowling", "Bowling Alleys")
  def cocktail_bar(), do: Category.new(:cocktail_bar, "cocktailbars", "Cocktail Bars")
  def pharmacy(), do: Category.new(:pharmacy, "cannabisdispensaries", "Cannabis Dispensaries")
end
