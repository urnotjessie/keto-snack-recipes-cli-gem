class KetoSnackRecipes::CLI

  @@index_url = "https://ketodash.com/recipe?type=Snack"

  def call
    KetoSnackRecipes::Scraper.new.scrape_index_page(@@index_url)
    puts "It's time to explore Keto recipes for your favorite snacks!"
    list_recipes
    show_recipe
    goodbye
  end

  def list_recipes
    puts ""
    puts "What number recipes would you like to see? 1-10, 11-20, 21-30, 31-40 or 41-49?"
    puts ""
    input_number = gets.strip.to_i
    if input_number != 41
      @recipes = KetoSnackRecipes::Recipes.all[input_number - 1, 10]
      tp @recipes, :id, :name
      # @recipes.each do |recipe|
      #   puts "#{recipe.id}. #{recipe.name}"
      # end
    elsif input_number == 41
      @recipes = KetoSnackRecipes::Recipes.all[input_number - 1, 9]
      @recipes.each do |recipe|
        puts "#{recipe.id}. #{recipe.name}"
      end
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
        recipe = KetoSnackRecipes::Recipes.find_recipe(input.to_i - 1)
        puts "#{recipe.name} - #{recipe.description} - #{recipe.ingredients}"
      elsif input == "list"
        self.list_recipes
      end
    end
  end

  def goodbye
    puts "- Goodbye -"
  end

end
