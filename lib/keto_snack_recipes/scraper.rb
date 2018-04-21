require 'open-uri'
require 'Nokogiri'

class KetoSnackRecipes::Scraper

  def scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    get_recipes = html.css(".col-sm-6 .card")

    get_recipes.each_with_index do |recipe, index|
      KetoSnackRecipes::Recipes.new_from_index_page(recipe, index)
    end
  end

end
