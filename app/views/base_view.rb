class BaseView
  def ask_for(thing)
    puts "Whats the #{thing}?"
    gets.chomp
  end
end
