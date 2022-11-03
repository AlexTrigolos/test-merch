class CreateStockItemActions < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_item_actions do |t|
      t.datetime :given_at, null: true, default: nil
      t.references :stock_item, foreign_key: true, null: false
      t.references :employee, foreign_key: true, null: false
      t.references :employee_group, null: true, foreign_key: true
      t.timestamps
    end
  end
end
