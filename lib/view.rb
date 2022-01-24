class View
  def display(recipes) # an array of recipes
    puts 'Here are your recipes:'
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} -  #{recipe.prep_time} - #{recipe.rating} / 5"
    end
  end

  def ask_for(thing)
    puts "What is the #{thing} of the recipe?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Select a recipe number"
    print '> '
    gets.chomp.to_i - 1
  end
end
