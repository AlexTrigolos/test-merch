class CreateFavouriteEmployeeGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_employee_groups do |t|
      t.integer :employee_group_id
      t.integer :user_id
      t.index [:user_id, :employee_group_id] , name: 'index_favourite_employee_group'
      t.timestamps
    end
  end
end
