# frozen_string_literal: true

class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description} - #{recipe.prep_time} - (#{recipe.rating} / 5 stars)"
    end
  end

  def ask_user_for(word)
    puts "#{word}?"
    print '> '
    gets.chomp
  end

  def ask_user_for_index
    puts 'Number?'
    print '> '
    gets.chomp.to_i - 1
  end
end
