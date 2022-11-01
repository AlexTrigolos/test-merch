class CreateJoinTablesMerchesUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :merches, :users do |t|
      t.index [:merch_id, :user_id]
      t.timestamps
    end
  end
end
