class EmployeeGroupsMerch < ApplicationRecord
  belongs_to :employee_group
  belongs_to :merch
end