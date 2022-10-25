# frozen_string_literal: true

require_relative 'view'
require_relative 'recipe'
require_relative "scrape_all_recipes_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Get all recipes from cookbook
    recipes = @cookbook.all
    # 2. Give them to the view to display them
    @view.display_list(recipes)
  end

  def create
    # 1. Ask the user for a recipe name
    name = @view.ask_user_for("Name")
    # 2. Ask the user for a recipe description
    description = @view.ask_user_for("Description")
     # 3. Ask the user for a recipe prep time
    prep_time = @view.ask_user_for("Prep Time")
    # 4. Ask the user for a recipe rating
    rating = @view.ask_user_for("Rating")
    # 5. Create an instance of Recipe
    recipe = Recipe.new(name, description, prep_time, rating)
    # 6. Give the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. Show the use all the recipes
    list
    # 2. Ask the user for the recipe index
    index = @view.ask_user_for_index
    # 3. Give the index to the cookbook for it to remove it
    @cookbook.remove_recipe(index)
  end

  def import
    # Ask the user for an ingredient keyword
    ingredient = @view.ask_user_for("Ingredient")
    # Parsing logic and storing in results array
    scraper = ScrapeAllrecipesService.new(ingredient)
    web_results = scraper.call
    # Display them in an indexed list
    @view.display_list(web_results)
    # Ask the user which recipe to import (ask for an index)
    index = @view.ask_user_for_index
    # Look for the recipe at the given index in the results array
    recipe = web_results[index]
    # Add it to the Cookbook
    @cookbook.add_recipe(recipe)
  end


  # def import
  #   # Ask the user for an ingredient keyword
  #   ingredient = @view.ask_user_for("Ingredient")
  #   # Open then URL with the provided keyword
  #   # Parse the HTML document
  #   # Store the found recipes in a results array
  #   # Display them in an indexed list
  #   # Ask the user which recipe to import (ask for an index)
  #   # Look for the recipe at the given index in the results array
  #   # Add it to the Cookbook
  # end
end
