class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :stock_name, unique: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
