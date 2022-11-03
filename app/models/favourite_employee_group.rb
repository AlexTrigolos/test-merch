class FavouriteEmployeeGroup < ApplicationRecord
  belongs_to :employee_group
  belongs_to :user
end