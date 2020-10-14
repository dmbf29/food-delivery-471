require_relative 'base_view'

class OrdersView < BaseView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1} | #{order.meal.name} - ¥#{order.meal.price}"
        puts "Driver: #{order.employee.username} 🚗 => #{order.customer.name} - #{order.customer.address}"
        puts ''
      end
    else
      puts "No orders yet 🍽"
    end
  end
end
