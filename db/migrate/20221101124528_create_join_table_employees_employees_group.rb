class CreateJoinTableEmployeesEmployeesGroup < ActiveRecord::Migration[7.0]
  def change
    create_join_table :employees, :employee_groups do |t|
      t.index [:employee_id, :employee_group_id], name: 'my_index'
      t.timestamps
    end
  end
end
