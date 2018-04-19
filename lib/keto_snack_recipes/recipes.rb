class KetoSnackRecipes::Recipes

  attr_accessor :name, :carbs, :fat, :protein, :calories

  def self.list_all

    recipe_1 = self.new
    recipe_1.name = "Bacon Guacamole Balls"
    recipe_1.carbs = "1.4"
    recipe_1.fat = "15.2"
    recipe_1.protein = "3.4"
    recipe_1.calories = "156.0"

    recipe_2 = self.new
    recipe_2.name = "Zucchini Poppers"
    recipe_2.carbs = "1.4"
    recipe_2.fat = "15.2"
    recipe_2.protein = "3.4"
    recipe_2.calories = "156.0"

    [recipe_1, recipe_2]
  end

end
