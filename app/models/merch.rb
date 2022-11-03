class Merch < ApplicationRecord
  has_and_belongs_to_many :employee_groups
  belongs_to :category, class_name: 'Category'
  has_many :stock_items
  has_one :comment, as: :commentable
  has_many :favourite_merches
end
