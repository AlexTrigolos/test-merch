class CreateMerches < ActiveRecord::Migration[7.0]
  def change
    create_table :merches do |t|
      t.string :merch_name
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
