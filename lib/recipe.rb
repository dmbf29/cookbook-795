class Recipe
  attr_reader :name, :description, :rating, :prep_time

  # def initialize(name, description, rating, done, prep_time)
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = !@done
  end
end

# Recipe.new('spaghetti', 'pasta with sauce')
# Recipe.new(
#   name: 'spaghetti',
#   description: 'pasta with sauce',
#   rating: 5,
#   done: false,
#   prep_time: '20 min'
# )
