class KetoSnackRecipes::Scraper

  def scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    get_recipes = html.css(".col-sm-6 .card")

    get_recipes.each_with_index do |recipe, index|
      attr_hash = {
        name: recipe.css(".card-header a").attribute("title").value,
        recipe_url: "https://ketodash.com#{recipe.css(".card-header a").attribute("href").value}",
        id: index + 1,
        carbs: recipe.css(".card-block ul").css("li")[3].text.split(": ")[1],
        protein: recipe.css(".card-block ul").css("li")[1].text.split(": ")[1],
        fat: recipe.css(".card-block ul").css("li")[2].text.split(": ")[1],
        calories: recipe.css(".card-block ul").css("li")[0].text.split(": ")[1]
      }
      KetoSnackRecipes::Recipes.new.set_attrs(attr_hash)
    end
  end

  def scrape_recipe_page(recipe)
    recipe_html = Nokogiri::HTML(open(recipe.recipe_url))
    update_attr_hash = {
      description: recipe_html.css(".col-12 .d-print-none")[1].text.gsub(".\n", ""),
      external_link: recipe_html.css(".col-12 a")[1].attribute("href").value,
      ingredients: recipe_html.css(".col-12 ul")[0].css("li")
    }
    KetoSnackRecipes::Recipes.update(recipe, update_attr_hash)
  end

end
