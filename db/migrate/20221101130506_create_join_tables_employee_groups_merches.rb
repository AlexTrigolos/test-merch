class CreateJoinTablesEmployeeGroupsMerches < ActiveRecord::Migration[7.0]
  def change
    create_join_table :employee_groups, :merches do |t|
      t.index [:employee_group_id, :merch_id]
      t.timestamps
     end
  end
end
