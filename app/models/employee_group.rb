class EmployeeGroup < ApplicationRecord
  has_and_belongs_to_many :employees
  has_one :comment, as: :commentable
  has_many :stock_item_actions
  has_many :merches, through: :employee_groups_merches
  belongs_to :user
  has_many :favourite_employee_groups
end
