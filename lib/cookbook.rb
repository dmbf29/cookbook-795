require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = [] # array of instances of Recipe
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  private

  def load_csv
    # populates the @recipes array with instances of Recipe
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # any time you load from a CSV,
      # you need to convert strings into their original value
      # row[:done] == 'true' # boolean
      row[:done] = row[:done] == 'true'
      recipe = Recipe.new(row)
      # recipe = Recipe.new(
      #   name: row[0],
      #   description: row[1],
      #   rating: row[2]
      # )
      @recipes << recipe # instance of Recipe
    end
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << ['name', 'description', 'rating', 'prep_time', 'done']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
