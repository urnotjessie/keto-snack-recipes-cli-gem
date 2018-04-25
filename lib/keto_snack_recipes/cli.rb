class KetoSnackRecipes::CLI

  @@index_url = "https://ketodash.com/recipe?type=Snack"

  def call
    KetoSnackRecipes::Scraper.new.scrape_index_page(@@index_url)
    puts ""
    puts "======== It's time to explore Keto recipes for your favorite snacks! ========".green.bold
    list_recipes
  end

  def list_recipes
    puts ""
    puts "What number recipes would you like to see? 1-10, 11-20, 21-30, 31-40 or 41-49?".green.bold
    puts ""
    input = gets.strip
    while input.to_i != nil
      if input.to_i.between?(1,31)
        @recipes = KetoSnackRecipes::Recipes.all[input.to_i - 1, 10]
        puts ""
        tp @recipes, :id, :name, :carbs, :protein, :fat, :calories
        show_recipe
        break

      elsif input.to_i == 41
        @recipes = KetoSnackRecipes::Recipes.all[input.to_i - 1, 9]
        puts ""
        tp @recipes, :id, :name, :carbs, :protein, :fat, :calories
        show_recipe
        break

      elsif input == "exit"
        goodbye
        break

      else
        puts ""
        puts "Please choose from 1-10, 11-20, 21-30, 31-40, 41-49 or enter exit to exit the program.".green.bold
        puts ""
        input = gets.strip
      end
    end
  end

  def show_recipe
    input = nil
    while input != "exit"
      puts ""
      puts "Which recipes would you like more information on?".green.bold
      puts ""
      puts "-- Enter a recipe number to view recipe details.".green
      puts "-- Enter list to select another list.".green
      puts "-- Enter exit to exit the program.".green
      puts ""
      input = gets.strip.downcase
      if input.to_i > 0
        recipe = KetoSnackRecipes::Recipes.find_recipe(input.to_i - 1)
        puts ""
        puts "------------------------------  #{recipe.name}  ------------------------------".black.on_white
        puts ""
        puts "#{recipe.description}".light_blue
        puts ""
        puts "-------------------------------  Ingredients  -------------------------------".black.on_white
        puts ""
        recipe.ingredients.each{|ingredient| puts "•  #{ingredient.text}".light_blue}
        puts ""
        if recipe.external_link != "javascript:window.print()"
          puts "---------------------------  Original Recipe Link  ---------------------------".black.on_white
          puts ""
          puts "#{recipe.external_link}".light_blue
          puts""
        end
      elsif input == "list"
        self.list_recipes
      elsif input == "exit"
        goodbye
      end
    end
  end

  def goodbye
    puts ""
    puts "- Goodbye -".green.bold
    puts ""
  end

end
