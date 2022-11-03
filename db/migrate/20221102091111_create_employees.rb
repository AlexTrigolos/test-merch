class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
        t.string :first_name
        t.string :last_name
        t.string :user_name, null: false, unique: true
        t.string :position
        t.integer :manager_id
        t.string :specializations, null: false
        t.string :city_name, null: false
        t.integer :hr_id
        t.integer :pr_id, null: false
        t.string :email
        t.string :telegram
        t.string :room
        t.integer :salary_office_id
        t.string :gender
        t.string :shirt_size
        t.boolean :being_dismissed, null: false
        t.boolean :being_hired, null: false
        t.boolean :is_working, null: false
        t.boolean :in_maternity, null: false
        t.datetime :start_date
        t.datetime :end_date
        t.timestamps
    end
  end
end
