class CreateMerches < ActiveRecord::Migration[7.0]
  def change
    create_table :merches do |t|
      t.string :merch_name, unique: true
      t.references :category, foreign_key: true, null: false
      t.timestamps
    end
  end
end
