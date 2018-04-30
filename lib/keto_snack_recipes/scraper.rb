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
      KetoSnackRecipes::Recipes.new.new_from_index_page(attr_hash)
    end
  end

end
