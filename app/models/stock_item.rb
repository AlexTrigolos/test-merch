class StockItem < ApplicationRecord
  belongs_to :merch
  belongs_to :stock
  has_many :stock_item_actions
  has_one :comment, as: :commentable
end
