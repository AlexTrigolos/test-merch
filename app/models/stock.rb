class Stock < ApplicationRecord
  has_many :stock_items
  belongs_to :user
end
