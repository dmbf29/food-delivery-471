require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repo, customer_repo, employee_repo, order_repo)
    @meal_repository = meal_repo
    @customer_repository = customer_repo
    @employee_repository = employee_repo
    @order_repository = order_repo
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    # ask order repo for undelivered order
    orders = @order_repository.undelivered_orders
    # pass that to the orders view
    @orders_view.display(orders)
  end

  def add
    # show the meals
    meals = @meal_repository.all
    @meals_view.display(meals)
    # ask the user to select meal(index)
    index = @meals_view.ask_for('number').to_i - 1
    # get the instance of the meal with the index
    meal = meals[index]


    # show the customers
    customers = @customer_repository.all
    @customers_view.display(customers)
    # ask the user to select customer(index)
    index = @customers_view.ask_for('number').to_i - 1
    # get the instance of the customer with the index
    customer = customers[index]

    # show the delivery_guys
    employees = @employee_repository.all_delivery_guys
    @employees_view.display(employees)
    # ask the user to select employee(index)
    index = @employees_view.ask_for('number').to_i - 1
    # get the instance of the employee with the index
    employee = employees[index]

    # create an instance of an order
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # save it in the repo
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    my_orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(my_orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    index = @customers_view.ask_for('order number').to_i - 1
    @order_repository.mark_as_delivered(index, employee)
  end
end









#
