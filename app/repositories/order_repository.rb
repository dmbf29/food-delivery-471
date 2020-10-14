require 'csv'
require_relative '../models/order'
require_relative '../models/meal'

class OrderRepository
  def initialize(csv_file_path, meal_repo, customer_repo, employee_repo)
    @csv_file_path = csv_file_path
    @orders = [] # in-memory DB
    @next_id = 1
    @meal_repository = meal_repo
    @customer_repository = customer_repo
    @employee_repository = employee_repo
    load_csv if File.exist?(@csv_file_path) # needs to talk to the repos
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def mark_as_delivered(index, employee)
    # get an order
    orders = my_undelivered_orders(employee)
    order = orders[index]
    # mark that order
    order.deliver!
    # save it
    save_csv
  end


  def create(order) # INSTANCE
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # covert string CSV values to the real data
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'

      meal = @meal_repository.find(row[:meal_id].to_i)
      row[:meal] = meal

      customer = @customer_repository.find(row[:customer_id].to_i)
      row[:customer] = customer

      employee = @employee_repository.find(row[:employee_id].to_i)
      row[:employee] = employee
      @orders << Order.new(row)
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
