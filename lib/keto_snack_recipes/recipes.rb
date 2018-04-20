class KetoSnackRecipes::Recipes

  attr_accessor :name, :carbs, :fat, :protein, :calories, :description, :ingredients, :nutritional_info, :url, :instruction_url

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url

    @@all << self
  end

  def self.new_from_index_page(recipe)
    self.new(
      recipe.css(".card-header a").attribute("title").value,
      recipe.css(".card-header a").attribute("href").value
    )
  end

  def self.all
    @@all
  end

end
