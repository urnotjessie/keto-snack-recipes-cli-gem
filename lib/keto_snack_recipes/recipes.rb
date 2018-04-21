require 'pry'

class KetoSnackRecipes::Recipes

  attr_accessor :name, :carbs, :fat, :protein, :calories, :description, :ingredients, :nutritional_info, :url, :link

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url

    @@all << self
  end

  def self.new_from_index_page(recipe)
    self.new(
      recipe.css(".card-header a").attribute("title").value,
      "https://ketodash.com#{recipe.css(".card-header a").attribute("href").value}"
    )
  end

  def self.all
    @@all
  end

  def self.new_from_recipe_url(html, recipe_url)
    recipe = self.new(
      html.css("h1").text,
      recipe_url
    )
    recipe.description = html.css(".col-12 .d-print-none")[1].text.gsub(".\n", "")
    recipe.link = html.css(".col-12 a")[1].attribute("href").value
    recipe.ingredients = html.css(".col-12 ul")[0].css("li").text
    recipe
  end


end
