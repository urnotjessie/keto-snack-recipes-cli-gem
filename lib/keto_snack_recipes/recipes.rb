require 'pry'
require 'open-uri'
require 'Nokogiri'

class KetoSnackRecipes::Recipes

  attr_accessor :name, :carbs, :fat, :protein, :calories, :description, :ingredients, :nutritional_info, :recipe_url, :recipe_html, :external_link

  @@all = []

  def initialize(name, recipe_url)
    @name = name
    @recipe_url = recipe_url

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

  def self.find_recipe(index)
    @@all[index]
  end

  def recipe_html
    @recipe_html ||= Nokogiri::HTML(open(@recipe_url))
  end

  def description
    @description ||= self.recipe_html.css(".col-12 .d-print-none")[1].text.gsub(".\n", "")
  end

  def external_link
    @external_link ||= self.recipe_html.css(".col-12 a")[1].attribute("href").value
  end

  def ingredients
    @ingredients ||= self.recipe_html.css(".col-12 ul")[0].css("li").text
  end


end
