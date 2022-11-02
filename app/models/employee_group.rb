class EmployeeGroup < ApplicationRecord
  has_many :employees, through: :employees_employees_group
  has_many :comments, as: :commentable
  has_many :stock_item_actions
  has_many :merches, through: :employee_groups_merches
  belongs_to :user
end
