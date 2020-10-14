require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    # ask the user for username
    username = @view.ask_for('username')
    # ask the user for password
    password = @view.ask_for('password')
    # employee = ask the employee repository for an employee by the username
    employee = @employee_repository.find_by_username(username)
    # check to see if that employee's password matches with the one given
    # if employee&.password == password
    if employee && employee.password == password
      @view.successfully_signed_in(employee)
      # sign them in
      return employee
    else
      @view.unsuccessfully_signed_in
      # ask them to sign in again
      sign_in
    end
  end
end
