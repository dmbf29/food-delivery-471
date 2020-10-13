class Meal
  attr_accessor :id
  attr_reader :name, :price

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end
end

# meal[:name]
# meal.name

# order.csv

# airbnb.com/homes/123123
# home = homes_repo.find(123123)
