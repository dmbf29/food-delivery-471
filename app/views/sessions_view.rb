require_relative 'base_view'
require 'io/console'

class SessionsView < BaseView
  def successfully_signed_in(employee)
    print `clear`
    puts "Welcome #{employee.username}!".blue.on_white
    puts ''
  end

  def unsuccessfully_signed_in
    print `clear`
    puts "Wrong username or password. Try again.".red
    puts ''
  end

  def ask_for_password
    puts "What's the password?"
    STDIN.noecho(&:gets).chomp
  end
end
