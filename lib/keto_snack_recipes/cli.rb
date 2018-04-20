class KetoSnackRecipes::CLI

  @index_url = "https://ketodash.com/recipe?type=Snack"

  def call
    KetoSnackRecipes::Scraper.new.scrape_index_page("https://ketodash.com/recipe?type=Snack")
    puts "It's time to explore Keto recipes for your favorite snacks!"
    list_recipes
    show_recipe
    goodbye
  end

  def list_recipes
    @recipes = KetoSnackRecipes::Recipes.all
    @recipes.each.with_index(1) do |recipe, index|
      puts "#{index}. #{recipe.name}"
    end
  end

  def show_recipe
    input = nil
    while input != "exit"
      puts "Which recipes would you like more information on?"
      puts "Enter a recipe number to view recipe details."
      puts "Enter list to see all recipes again."
      puts "Enter exit to exit the program."
      input = gets.strip.downcase
      if input.to_i > 0
        recipe_url = @recipes[input.to_i - 1].url
        recipe = KetoSnackRecipes::Scraper.new.scrape_recipe_page(recipe_url)
        puts "#{recipe.name} - #{recipe.description}"
      elsif input == "list"
        self.list_recipes
      end
    end
  end

  def goodbye
    puts "- Goodbye -"
  end

end
