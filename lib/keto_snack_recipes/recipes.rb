class KetoSnackRecipes::Recipes

  attr_accessor :name, :id, :carbs, :fat, :protein, :calories, :description, :ingredients, :nutritional_info, :recipe_url, :recipe_html, :external_link

  @@all = []

  def initialize()
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

  # def recipe_html
  #   @recipe_html ||= Nokogiri::HTML(open(@recipe_url))
  # end
  #
  # def description
  #   @description ||= self.recipe_html.css(".col-12 .d-print-none")[1].text.gsub(".\n", "")
  # end
  #
  # def external_link
  #   @external_link ||= self.recipe_html.css(".col-12 a")[1].attribute("href").value
  # end
  #
  # def ingredients
  #   @ingredients ||= self.recipe_html.css(".col-12 ul")[0].css("li")
  # end
end
