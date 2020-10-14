class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # INSTANCE OF A MEAL
    @customer = attributes[:customer] # INSTANCE OF A CUSTOMER
    @employee = attributes[:employee] # INSTANCE OF A EMPLOYEE(d_g)
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = !@delivered
  end
end
