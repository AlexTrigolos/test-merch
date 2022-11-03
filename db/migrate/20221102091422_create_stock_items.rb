class CreateStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_items do |t|
      t.string :size, default: "all-sizes"
      t.string :sex, default: "all-sexes"
      t.references :merch, foreign_key: true, null: false
      t.references :stock, foreign_key: true, null: false
      t.string :status, null: false
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end
  end
end
