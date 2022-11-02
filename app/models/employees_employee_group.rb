class EmployeesEmployeeGroup < ApplicationRecord
  belongs_to :employee_group
  belongs_to :employee
end