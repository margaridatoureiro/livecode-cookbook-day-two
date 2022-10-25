# frozen_string_literal: true

require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # array of `Recipe` instances
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  # recipe is a `Recipe` instance
  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      # row is an array
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.rating]
      end
    end
  end
end
