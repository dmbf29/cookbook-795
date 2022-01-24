require 'nokogiri'
require 'open-uri'
# We're going to write all of our scraping logic here
# This is a controller helper class -> Service Object
# We could write this in the controller, but staying clean here

# Nokogiri methods
# .search('selector') -> give a collection of objects
# .text -> give us a string inside the elements

# doc.search('h1') # html tags
# doc.search('.class') # a class
# doc.search('.class.another_class') # an element with both
# doc.search('.parent .child') # an child element inside of a parent. need the space!
# # <div class='parent'>
# #  <p class='child'>Text</p>
# # </div>
# doc.search('#id') # an id
# baner = doc.search('#banner') # search within a search
# banner.search('p')
# doc.search # will always give you an array of things that match

class ScrapeRecipes
  def initialize(keyword)
    @keyword = keyword
  end

  # DONT DISPLAY HERE -> only the view's job to display
  def call
    # TODO
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html = URI.open(url).read
    doc = Nokogiri::HTML(html) # collection of Nokogiri objects
    # i need to find the name and description
    # ONLY iterate over first 5
    doc.search('.card__detailsContainer').each do |card_element|
      p name = card_element.search('.card__title').text.strip
      # get the description
      # create an instance of a recipe
    end
    # should be returning.... an array of recipe INSTANCES
  end
end

ScrapeRecipes.new('cheesecake').call
