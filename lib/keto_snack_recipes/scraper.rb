require 'open-uri'
require 'Nokogiri'

class KetoSnackRecipes::Scraper

  def scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    get_recipes = html.css(".col-sm-6 .card")

    get_recipes.each_with_index do |recipe|
      KetoSnackRecipes::Recipes.new_from_index_page(recipe)
    end

  end

  def scrape_recipe_page(recipe_url, index)
    html = Nokogiri::HTML(open(recipe_url))
    KetoSnackRecipes::Recipes.new_from_recipe_url(html, index)
  end

end
