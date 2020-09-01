# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Item.destroy_all

30.times do
  Customer.create email: Faker::Internet.email,
                  birthdate: Faker::Date.birthday(min_age: 21)
end

30.times do
  Item.create title: Faker::Commerce.product_name,
              price: Faker::Commerce.price(range: 0.1..150.0)
end

items = Item.all
Customer.all.each do |customer|
  order_1 = customer.orders.build number: Faker::Commerce.promotion_code,
                         date: Faker::Date.backward(days: 30)
  order_1.order_items.build item: items[rand(0..29)], quantity: rand(1.0..10.0)
  order_1.save
  order_2 = customer.orders.create number: Faker::Commerce.promotion_code,
                         date: Faker::Date.backward(days: 30)
  order_2.order_items.build item: items[rand(0..29)], quantity: rand(1.0..10.0)
  order_2.save
end
