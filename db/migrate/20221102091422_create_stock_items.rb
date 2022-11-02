class CreateStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_items do |t|
      t.string :size, default: "all-sizes"
      t.string :sex, default: "all-sexes"
      t.references :merch, foreign_key: true
      t.references :stock, foreign_key: true
      t.string :status
      t.integer :quantity, null: true, default: 0
      t.timestamps
    end
  end
end
