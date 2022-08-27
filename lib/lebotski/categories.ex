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

  def pharmacy(), do: Category.new("cannabisdispensaries", "Cannabis Dispensaries")
end
