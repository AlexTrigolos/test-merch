class Merch < ApplicationRecord
  has_many :employee_groups, through: :employee_groups_merches
  belongs_to :categories
  has_many :stock_items
  has_many :comments, as: :commentable
  belongs_to :user

end
