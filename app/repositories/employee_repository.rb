require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = [] # in-memory DB
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # covert string CSV values to the real data
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
