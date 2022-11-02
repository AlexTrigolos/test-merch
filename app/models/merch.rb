class Merch < ApplicationRecord
  has_many :employee_groups, through: :employee_groups_merches
  belongs_to :category, class_name: 'Category'
  has_many :stock_items
  has_one :comment, as: :commentable
  has_many :favourite_merches
end
