class FavouriteMerch < ApplicationRecord
  belongs_to :merch
  belongs_to :user
end
