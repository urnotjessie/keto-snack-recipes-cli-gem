class KetoSnackRecipes::Recipes

  attr_accessor :name, :id, :carbs, :fat, :protein, :calories, :description, :ingredients, :nutritional_info, :recipe_url, :recipe_html, :external_link

  @@all = []

  def initialize
    @@all << self
  end

  def set_attrs(attr_hash)
    attr_hash.each{|key, value| self.send("#{key}=", value)}
  end

  def self.all
    @@all
  end

  def self.update(recipe, update_attr_hash)
    update_attr_hash.each{|key, value| recipe.send("#{key}=", value)}
  end
end
