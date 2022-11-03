# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

name = Faker::Name
email = Faker::Internet
date = Faker::Date
company = Faker::Company
alphanumeric = Faker::Alphanumeric
bool = Faker::Boolean
employee_count = 100
min_stock_item_action_count = 8
max_stock_item_action_count = 12
employee_group_count = 11
stock_item_count = 50
room_count = 100
salary_office_count = 4
user_count = 10
merch_count = 10
stock_count = 4
category_count = 6
# comment_employee_count = (employee_count / 2).floor
# comment_stock_item_action_count = (min_stock_item_action_count * employee_count / 2).floor
# comment_stock_item_count = (stock_item_count / 2).floor
# comment_employee_group_count = (employee_group_count / 2).floor
# comment_merch_count = (merch_count / 2).floor

def size
  case rand(6)
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
  case rand(3)
  when 0
    'in stock'
  when 1
    'out of stock'
  else
    'archive'
  end
end

Category.create!(category_name: 'clothewrs')
Category.create!(category_name: 'katstovari')
Category.create!(category_name: 'posuda')
Category.create!(category_name: 'sumki')
Category.create!(category_name: 'aksessuari')
Category.create!(category_name: 'other')

user_count.times do
  User.create!(
    username: alphanumeric.alpha(number: rand(8..20))
  )
end

stock_count.times do
  Stock.create!(
    stock_name: alphanumeric.alpha(number: rand(8..20)),
    user_id: User.find(rand(1..user_count)).id
  )
end

merch_count.times do
  Merch.create!(
    merch_name: alphanumeric.alpha(number: rand(5..15)),
    category_id: Category.find(rand(1..category_count)).id
  )

  user_count.times do |index|
    if Merch.last.id % 3 == index % 3
      FavouriteMerch.create!(
        merch_id: Merch.last.id,
        user_id: index + 1
      )
    end
  end
end

employee_group_count.times do
  EmployeeGroup.create!(
    group_name: company.profession,
    user_id: User.find(rand(1..user_count)).id
  )

  merch_count.times do |index|
    if EmployeeGroup.last.id % 3 == index % 3
      EmployeeGroupsMerch.create!(
        employee_group_id: EmployeeGroup.last.id,
        merch_id: index + 1
      )
    end
  end

  user_count.times do |index|
    if EmployeeGroup.last.id % 3 == index % 3
      FavouriteEmployeeGroup.create!(
        employee_group_id: EmployeeGroup.last.id,
        user_id: index + 1
      )
    end
  end

end

stock_item_count.times do
  status = stock_item_status
  StockItem.create!(
    size: size,
    sex: Faker::Gender.binary_type,
    merch_id: Merch.find(rand(1..merch_count)).id,
    stock_id: Stock.find(rand(1..stock_count)).id,
    status: status,
    quantity: status == 'in stock' ? rand(1..200) : 0
  )
end

employee_count.times do |index|
  p index if index % 10 == 0
  start_date_employee = date.between(from: '2014-09-23', to: Date.today)
  end_date_employee = rand(3) == 1 ? nil : date.between(from: start_date_employee.to_s, to: Date.today)
  Employee.create!(
    first_name: name.first_name,
    last_name: name.last_name,
    user_name: name.middle_name,
    position: "position - #{alphanumeric.alpha(number: 10)}",
    manager_id: rand(1..employee_count),
    specializations: "specializations - #{alphanumeric.alpha(number: 10)}",
    city_name: "city_name - #{alphanumeric.alpha(number: 10)}",
    hr_id: rand(1..employee_count),
    pr_id: rand(1..employee_count),
    email: email.email,
    telegram: "tg - @#{alphanumeric.alpha(number: 10)}",
    room: rand(1..room_count),
    salary_office_id: rand(1..salary_office_count),
    gender: Faker::Gender.binary_type,
    shirt_size: size,
    being_dismissed: bool.boolean,
    being_hired: bool.boolean,
    is_working: bool.boolean,
    in_maternity: bool.boolean,
    start_date: start_date_employee,
    end_date: end_date_employee
  )

  employee_group_count.times do |elem|
    if Employee.last.id % 3 == elem % 3
      EmployeesEmployeeGroup.create!(
        employee_group_id: elem + 1,
        employee_id: Employee.last.id
      )
    end
  end

  rand(min_stock_item_action_count..max_stock_item_action_count).times do
    now_stock_item_id = rand(1..stock_item_count)
    array = []
    EmployeeGroupsMerch.where(merch_id: StockItem.find(now_stock_item_id).merch_id).each do |elem|
      array.push(elem.employee_group_id)
    end

    StockItemAction.create!(
      given_at: bool.boolean ? nil : date.between(from: start_date_employee.to_s, to: end_date_employee == nil ? Date.today : end_date_employee.to_s),
      stock_item_id: StockItem.find(now_stock_item_id).id,
      employee_id: Employee.last.id,
      employee_group_id: array.sample
    )

    if bool.boolean
      Comment.create!(
        user_id: User.find(rand(1..user_count)).id,
        body: alphanumeric.alpha(number: rand(1..1000)),
        commentable_id: StockItemAction.last.id,
        commentable_type: "StockItemAction"
      )
    end
  end
end

employee_count.times do |index|
  if bool.boolean
    Comment.create!(
      user_id: User.find(rand(1..user_count)).id,
      body: alphanumeric.alpha(number: rand(1..1000)),
      commentable_id: index + 1,
      commentable_type: "Employee"
    )
  end
end

stock_item_count.times do |index|
  if bool.boolean
    Comment.create!(
      user_id: User.find(rand(1..user_count)).id,
      body: alphanumeric.alpha(number: rand(1..1000)),
      commentable_id: index + 1,
      commentable_type: "StockItem"
    )
  end
end

employee_group_count.times do |index|
  if bool.boolean
    Comment.create!(
      user_id: User.find(rand(1..user_count)).id,
      body: alphanumeric.alpha(number: rand(1..1000)),
      commentable_id: index + 1,
      commentable_type: "EmployeeGroup"
    )
  end
end

merch_count.times do |index|
  if bool.boolean
    Comment.create!(
      user_id: User.find(rand(1..user_count)).id,
      body: alphanumeric.alpha(number: rand(1..1000)),
      commentable_id: index + 1,
      commentable_type: "Merch"
    )
  end
end
