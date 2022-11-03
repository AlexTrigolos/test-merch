class CreateEmployeeGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_groups do |t|
      t.string :group_name, unique: true, null: false
      t.references :user, foreign_key: true, null: true
      t.timestamps
    end
  end
end
