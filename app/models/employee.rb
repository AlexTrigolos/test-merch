class Employee < ApplicationRecord
  has_one :comment, as: :commentable
  has_many :stock_item_actions
  has_and_belongs_to_many :employee_groups
end
