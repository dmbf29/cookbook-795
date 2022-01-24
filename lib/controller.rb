require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_recipes'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # 1. Ask the user for the name of the recipe and the description
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep time')
    # 2. Create an instance of Recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # 3. Add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. List the recipes
    display_recipes
    # 2. Ask the user for a recipe index
    index_to_remove = @view.ask_for_index
    # 3. Remove the recipe from the cookbook
    @cookbook.remove_recipe(index_to_remove)
  end

  def import
    # tell view to ask user for keyword
    # keyword = get the user input
    keyword = @view.ask_for('keyword') # string (thing we're searching for)
    # recipes = give the keyword to the scraper class (this shoudl give us an array of INSTANCES)
    recipes = ScrapeRecipes.new(keyword).call
    # tell the view to display the recipes
    @view.display(recipes)
    # Tell the view to ask for the recipe number
    # index = get the user input (and convert to an index)
    index = @view.ask_for_index
    # recipe = get the instance of the recipe using the index
    recipe = recipes[index]
    # give that recipe to the cookbook (repository)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display recipes
    display_recipes
    # ask user which recipe to mark
    index = @view.ask_for_index
    # mark and save
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    # 1. Get the recipes from the cookbook
    recipes = @cookbook.all
    # 2. Ask the view to display the recipes
    @view.display(recipes)
  end
end
