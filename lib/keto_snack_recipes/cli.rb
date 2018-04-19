class KetoSnackRecipes::CLI

  def call
    puts "It's time to explore Keto recipes for your favorite snacks!"
    list_recipes
    menu
    goodbye
  end

  def list_recipes
    @recipes = KetoSnackRecipes::Recipes.list_all
    @recipes.each.with_index(1) do |recipe, index|
      puts "#{index}. #{recipe.name} - #{recipe.carbs} - #{recipe.fat} - #{recipe.protein} - #{recipe.calories}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Which recipes would you like more information on?"
      puts "Enter a recipe number to view recipe details."
      puts "Enter list to see all recipes again."
      puts "Enter exit to exit the program."
      input = gets.strip.downcase
      if input.to_i > 0
        recipe = @recipes[input.to_i - 1]
        puts "#{recipe.name} - #{recipe.carbs}"
      elsif input == "list"
        self.list_recipes
      end
    end
  end

  def goodbye
    puts "- Goodbye -"
  end

end
