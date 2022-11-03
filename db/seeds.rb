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
employee_count = 600
min_stock_item_action_count = 8
max_stock_item_action_count = 12
employee_group_count = 21
stock_item_count = 150
room_count = 200
salary_office_count = 7
user_count = 10
merch_count = 20
stock_count = 7

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

def employee_stock_item_action_date(employee)
  Faker::Date.between(from: employee.start_date.nil? ? Date.today : employee.start_date,
                      to: employee.end_date.nil? ? Date.today : employee.end_date)
end

Category.create!(category_name: 'Одежда')
Category.create!(category_name: 'Канцтовары')
Category.create!(category_name: 'Посуда')
Category.create!(category_name: 'Сумки')
Category.create!(category_name: 'Аксессуары')
Category.create!(category_name: 'Прочее')

user_count.times do
  User.create!(
    username: alphanumeric.alpha(number: rand(8..20))
  )
end

stock_count.times do
  Stock.create!(
    stock_name: alphanumeric.unique.alpha(number: rand(8..20)),
    user_id: User.find(rand(1..user_count)).id
  )
end

merch_count.times do
  Merch.create!(
    merch_name: alphanumeric.unique.alpha(number: rand(5..15)),
    category_id: Category.find(rand(1..Category.all.count)).id
  )

  user_count.times do |index|
    if bool.boolean(true_ratio: 0.3333)
      FavouriteMerch.create!(
        merch_id: Merch.last.id,
        user_id: index + 1
      )
    end
  end
end

employee_group_count.times do
  EmployeeGroup.create!(
    group_name: company.unique.profession,
    user_id: bool.boolean(true_ratio: 0.2) ? nil : rand(1..user_count)
  )

  merch_count.times do |index|
    if bool.boolean(true_ratio: 0.3333)
      EmployeeGroupsMerch.create!(
        employee_group_id: EmployeeGroup.last.id,
        merch_id: index + 1
      )
    end
  end

  user_count.times do |index|
    if bool.boolean(true_ratio: 0.3333)
      FavouriteEmployeeGroup.create!(
        employee_group_id: EmployeeGroup.last.id,
        user_id: index + 1
      )
    end
  end

end

stock_item_count.times do
  status = stock_item_status
  merch = Merch.find(rand(1..merch_count))
  StockItem.create!(
    size: Category.find(merch.category_id).category_name == 'Одежда' ? size : 'all-sizes',
    sex: Category.find(merch.category_id).category_name == 'Одежда' ? Faker::Gender.binary_type : 'all-sexes',
    merch_id: merch.id,
    stock_id: Stock.find(rand(1..stock_count)).id,
    status: status,
    quantity: status == 'in stock' ? rand(1..200) : 0
  )
end

employee_count.times do
  start_date_employee = date.between(from: '2014-09-23', to: Date.today)
  end_date_employee = date.between(from: start_date_employee.to_s, to: Date.today)
  Employee.create!(
    first_name: bool.boolean(true_ratio: 0.1) ? nil : name.first_name,
    last_name: bool.boolean(true_ratio: 0.1) ? nil : name.last_name,
    user_name: name.unique.middle_name,
    position: bool.boolean(true_ratio: 0.1) ? nil : "position - #{alphanumeric.alpha(number: 10)}",
    manager_id: bool.boolean(true_ratio: 0.1) ? nil : rand(1..employee_count),
    specializations: "specializations - #{alphanumeric.alpha(number: 10)}",
    city_name: "city_name - #{alphanumeric.alpha(number: 10)}",
    hr_id: bool.boolean(true_ratio: 0.1) ? nil : rand(1..employee_count),
    pr_id: rand(1..employee_count),
    email: bool.boolean(true_ratio: 0.1) ? nil : email.email,
    telegram: bool.boolean(true_ratio: 0.1) ? nil : "tg - @#{alphanumeric.alpha(number: 10)}",
    room: bool.boolean(true_ratio: 0.1) ? nil : rand(1..room_count),
    salary_office_id: bool.boolean(true_ratio: 0.1) ? nil : rand(1..salary_office_count),
    gender: bool.boolean(true_ratio: 0.1) ? nil : Faker::Gender.binary_type,
    shirt_size: bool.boolean(true_ratio: 0.1) ? nil : size,
    being_dismissed: bool.boolean,
    being_hired: bool.boolean,
    is_working: bool.boolean,
    in_maternity: bool.boolean,
    start_date: bool.boolean(true_ratio: 0.1) ? nil : start_date_employee,
    end_date: bool.boolean(true_ratio: 0.1) ? nil : end_date_employee
  )

  employee_group_count.times do |elem|
    if bool.boolean(true_ratio: 0.3333)
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
      given_at: bool.boolean(true_ratio: 0.2) ? nil : employee_stock_item_action_date(Employee.last),
      stock_item_id: StockItem.find(now_stock_item_id).id,
      employee_id: Employee.last.id,
      employee_group_id: bool.boolean(true_ratio: 0.1) ? nil : array.sample
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
