require_relative 'base_view'

class SessionsView < BaseView
  def successfully_signed_in(employee)
    puts "Welcome #{employee.username}!"
  end

  def unsuccessfully_signed_in
    print `clear`
    puts "Wrong username or password. Try again."
  end
end
