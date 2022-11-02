class User < ApplicationRecord
  has_many :stock_items
  has_many :comments
  has_many :employee_groups
  has_many :employee_group, through: :employee_groups_users
  has_many :merches, through: :merches_users
end
