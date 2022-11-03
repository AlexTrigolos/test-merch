class CreateTableEmployeeGroupsMerches < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_groups_merches do |t|
      t.references :employee_group, null: false, foreign_key: true
      t.references :merch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
