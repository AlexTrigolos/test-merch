class User < ApplicationRecord
  has_many :stocks
  has_many :comments
  has_many :employee_groups
  has_many :favourite_employee_groups
  has_many :favourite_merches
end
