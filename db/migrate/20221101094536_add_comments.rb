 class AddComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.references :commentable, polymorphic: true, index: true
    end
  end
end
