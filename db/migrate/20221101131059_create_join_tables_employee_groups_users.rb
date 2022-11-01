class CreateJoinTablesEmployeeGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :employee_groups, :users do |t|
      t.index [:employee_group_id, :user_id]
      t.timestamps
    end
  end
end
