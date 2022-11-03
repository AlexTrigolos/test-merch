class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :stock_name, unique: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
