class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
        t.string :first_name
        t.string :last_name
        t.string :user_name
        t.string :position
        t.integer :manager_id
        t.string :specializations
        t.string :city_name
        t.integer :hr_id
        t.integer :pr_id
        t.string :email
        t.string :telegram
        t.string :room
        t.integer :salary_office_id
        t.string :gender
        t.string :shirt_size
        t.boolean :being_dismissed
        t.boolean :being_hired
        t.boolean :is_working
        t.boolean :in_maternity
        t.datetime :start_date
        t.datetime :end_date
        t.timestamps
    end
  end
end
