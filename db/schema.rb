# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_02_091424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "employee_groups", force: :cascade do |t|
    t.string "group_name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employee_groups_on_user_id"
  end

  create_table "employee_groups_employees", id: false, force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "employee_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "employee_group_id"], name: "my_index"
  end

  create_table "employee_groups_merches", id: false, force: :cascade do |t|
    t.bigint "employee_group_id", null: false
    t.bigint "merch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_group_id", "merch_id"], name: "index_employee_groups_merches_on_employee_group_id_and_merch_id"
  end

  create_table "employee_groups_users", id: false, force: :cascade do |t|
    t.bigint "employee_group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_group_id", "user_id"], name: "index_employee_groups_users_on_employee_group_id_and_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "position"
    t.integer "manager_id"
    t.string "specializations"
    t.string "city_name"
    t.integer "hr_id"
    t.integer "pr_id"
    t.string "email"
    t.string "telegram"
    t.string "room"
    t.integer "salary_office_id"
    t.string "gender"
    t.string "shirt_size"
    t.boolean "being_dismissed"
    t.boolean "being_hired"
    t.boolean "is_working"
    t.boolean "in_maternity"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merches", force: :cascade do |t|
    t.string "merch_name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_merches_on_category_id"
  end

  create_table "merches_users", id: false, force: :cascade do |t|
    t.bigint "merch_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merch_id", "user_id"], name: "index_merches_users_on_merch_id_and_user_id"
  end

  create_table "stock_item_actions", force: :cascade do |t|
    t.datetime "given_at"
    t.bigint "stock_item_id"
    t.bigint "employee_id"
    t.bigint "employee_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_group_id"], name: "index_stock_item_actions_on_employee_group_id"
    t.index ["employee_id"], name: "index_stock_item_actions_on_employee_id"
    t.index ["stock_item_id"], name: "index_stock_item_actions_on_stock_item_id"
  end

  create_table "stock_items", force: :cascade do |t|
    t.string "size", default: "all-sizes"
    t.string "sex", default: "all-sexes"
    t.bigint "merch_id"
    t.bigint "stock_id"
    t.string "status"
    t.bigint "quantity_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merch_id"], name: "index_stock_items_on_merch_id"
    t.index ["quantity_id"], name: "index_stock_items_on_quantity_id"
    t.index ["stock_id"], name: "index_stock_items_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "stock_name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "employee_groups", "users"
  add_foreign_key "merches", "categories"
  add_foreign_key "stock_item_actions", "employee_groups"
  add_foreign_key "stock_item_actions", "employees"
  add_foreign_key "stock_item_actions", "stock_items"
  add_foreign_key "stock_items", "merches"
  add_foreign_key "stock_items", "stocks"
  add_foreign_key "stocks", "users"
end