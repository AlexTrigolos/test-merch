class StockItemAction < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_group, optional: true
  belongs_to :stock_item
  has_one :comment, as: :commentable
end
