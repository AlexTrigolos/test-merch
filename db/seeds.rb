# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

string = Faker::String
name = Faker::Name
email = Faker::Internet
date = Faker::Date
company = Faker::Company
alphanumeric = Faker::Alphanumeric
employee_count = 600
min_stock_item_action_count = 8
max_stock_item_action_count = 12
employee_group_count = 11
stock_item_count = 50
room_count = 100
salary_office_count = 4
user_count = 10
merch_count = 5
stock_count = 4
category_count = 6
comment_employee_count = (employee_count / 2).floor
comment_stock_item_action_count = (min_stock_item_action_count * employee_count / 2).floor
comment_stock_item_count = (stock_item_count / 2).floor
comment_employee_group_count = (employee_group_count / 2).floor
comment_merch_count = (merch_count / 2).floor

def size
  rand_size = rand(6)
  case rand_size
  when 0
    's'
  when 1
    'm'
  when 2
    'l'
  when 3
    'xl'
  when 4
    'xxl'
  else
    'xxxl'
  end
end

def stock_item_status
  rand_status = rand(3)
  case rand_status
  when 0
    'in stock'
  when 1
    'out of stock'
  else
    'archive'
  end
end

user_count.times do
  User.create!(
    name: alphanumeric.alpha(number: rand(8..20))
  )
end

stock_count.times do
  Stock.create!(
    stock_name: alphanumeric.alpha(number: rand(8..20)),
    chief_user_id: User.find(rand(1..user_count))
  )
end

comment_employee_count.times do|index|
  Comment.create!(
    user_id: User.find(rand(1..user_count)),
    body: alphanumeric.alpha(number: rand(1..1000)),
    commentable_id: Employee.find(index * 2 - 1),
    commentable_type: "employee"
  )
end

comment_stock_item_count.times do|index|
  Comment.create!(
    user_id: User.find(rand(1..user_count)),
    body: alphanumeric.alpha(number: rand(1..1000)),
    commentable_id: Stock_item.find(index * 2 - 1),
    commentable_type: "stock item"
  )
end

comment_stock_item_action_count.times do|index|
  Comment.create!(
    user_id: User.find(rand(1..user_count)),
    body: alphanumeric.alpha(number: rand(1..1000)),
    commentable_id: Stock_item_action.find(index * 2 - 1),
    commentable_type: "stock item action"
  )
end

comment_employee_group_count.times do|index|
  Comment.create!(
    user_id: User.find(rand(1..user_count)),
    body: alphanumeric.alpha(number: rand(1..1000)),
    commentable_id: Employee_group.find(index * 2 - 1),
    commentable_type: "employee group"
  )
end

comment_merch_count.times do|index|
  Comment.create!(
    user_id: User.find(rand(1..user_count)),
    body: alphanumeric.alpha(number: rand(1..1000)),
    commentable_id: Merch.find(index * 2 - 1),
    commentable_type: "merch"
  )
end

category_count.create!(category_name: 'Одежда')
category_count.create!(category_name: 'Канцелярия')
category_count.create!(category_name: 'Посуда')
category_count.create!(category_name: 'Сумки')
category_count.create!(category_name: 'Аксессуары')
category_count.create!(category_name: 'Прочее')

employee_group_count.times do
  Employee_group.create!(
    group_name: company.profession,
    user_id: User.find(rand(1..user_count))
  )
end

employee_count.times do
  start_date_employee = date.between(from: '2014-09-23', to: Date.today)
  end_date_employee = rand(3) == 1 ? nil : date.between(from: start_date_employee, to: Date.today)
  Employee.create!(
    first_name: name.first_name,
    last_name: name.last_name,
    position: "position - #{string.random(length: 5..10)}",
    manager_id: rand(1..employee_count),
    specializations: "specializations - #{string.random(length: 5..10)}",
    city_name: "city_name - #{string.random(length: 5..10)}",
    hr_id: rand(1..employee_count),
    pr_id: rand(1..employee_count),
    email: email.email,
    telegram: "tg - #{string.random(length: 5..10)}",
    room: rand(1..room_count),
    salary_office_id: rand(1..salary_office_count),
    gender: Faker::Gender.binary_type,
    shirt_size: size,
    being_dismissed: rand(2) == 1 ? true : false,
    being_hired: rand(2) == 1 ? true : false,
    is_working: rand(2) == 1 ? true : false,
    in_maternity: rand(2) == 1 ? true : false,
    start_date: start_date_employee,
    end_date: end_date_employee
  )

  rand(min_stock_item_action_count..max_stock_item_action_count).times do
    Stock_item_action.create!(
      given_at: rand(2) == 1 ? nil : date.between(from: start_date_employee, to: end_date_employee == nil ? Date.today : end_date_employee),
      stock_item_id: Stock_item.find(rand(stock_item_count)),
      employee_id: Employee.last,
      group_id: rand(5) == 1 ? nil : Employee_Group.find(rand(employee_group_count))
    )
  end

  # rand(0..employee_group_count)
  # Employees_employee_group.

end

merch_count.times do
  Merch.create!(
    merch_name: alphanumeric.alpha(number: rand(5..15)),
    category_id: Category.find(rand(1..category_count))
  )
end

stock_item_count.times do
  status = stock_item_status
  Stock_item.create!(
    size: size,
    sex: Faker::Gender.binary_type,
    merch_id: Merch.find(rand(1..merch_count)),
    stock_id: Stock.find(rand(1..stock_count)),
    status: status,
    quanity: status == 'in stock' ? rand(1.. 200) : 0
  )
end
