require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # meals = ask the repo for all the meals
    meals = @meal_repository.all
    # give it to the view to display
    @meals_view.display(meals)
  end

  def create
    # the view ask the user for the name
    name = @meals_view.ask_for('name')
    # the view ask the user for the price
    price = @meals_view.ask_for('price').to_i
    # create a meal with name and price
    meal = Meal.new(
      name: name,
      price: price
    )
    # then we give it to the repo
    @meal_repository.add(meal)
  end
end
