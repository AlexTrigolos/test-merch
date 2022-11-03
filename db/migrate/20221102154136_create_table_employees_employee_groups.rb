class CreateTableEmployeesEmployeeGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :employees_employee_groups, id: false do |t|
      t.references :employee, foreign_key: true, null: false
      t.references :employee_group, foreign_key: true, null: false
      t.timestamps
    end
  end
end
