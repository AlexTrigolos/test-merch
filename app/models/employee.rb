class Employee < ApplicationRecord
  has_many :employee_group, through: :employees_employees_group
  has_many :comments, as: :commentable
  has_many :stock_item_actions
end
