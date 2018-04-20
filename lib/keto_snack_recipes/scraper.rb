require 'open-uri'
require 'Nokogiri'

class KetoSnackRecipes::Scraper

  def scrape_and_create_recipes
    html = Nokogiri::HTML(open("https://ketodash.com/recipe?type=Snack"))

    html.css(".col-sm-6 .card").each do |recipe|
      KetoSnackRecipes::Recipes.new_from_index_page(recipe)
    end
  end
end
