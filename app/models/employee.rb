class Employee
  attr_reader :username, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def manager?
    @role == 'manager'
  end

  def delivery_guy?
    @role == 'delivery_guy'
  end
end

# @token = "23234823420394820941092381lksjdalksdjalk"
# finds the user with this token
