class StockItemAction < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_group
  belongs_to :stock_item
  has_many :comments, as: :commentable
end
