class CreateFavouriteMerches < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_merches do |t|
      t.integer :merch_id, null: false
      t.integer :user_id, null: false
      t.index [:user_id, :merch_id], name: 'index_favourite_merches'
      t.timestamps
    end
  end
end
