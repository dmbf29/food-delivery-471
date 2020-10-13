require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # customers = ask the repo for all the customers
    customers = @customer_repository.all
    # give it to the view to display
    @customers_view.display(customers)
  end

  def create
    # the view ask the user for the name
    name = @customers_view.ask_for('name')
    # the view ask the user for the address
    address = @customers_view.ask_for('address')
    # create a customer with name and address
    customer = Customer.new(
      name: name,
      address: address
    )
    # then we give it to the repo
    @customer_repository.add(customer)
  end
end
