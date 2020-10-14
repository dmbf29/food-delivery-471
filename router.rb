class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts "Welcome to the Sexy Fish Restaurant!"
    puts "           --           "

    while @running
      # ask the user to sign_in
      @employee = @sessions_controller.sign_in
      # if the employee is a manager
      while @employee
        if @employee.manager?
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          puts "You're a delivery person"
          # display delivery guy actions
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.create
    when 3 then @customers_controller.list
    when 4 then @customers_controller.create
    when 9 then sign_out
    when 0 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def sign_out
    @employee = nil
  end

  def stop
    @employee = nil
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end
end
