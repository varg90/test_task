# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Item.destroy_all

30.times do |i|
  Customer.create email: "user#{i + 1}@example.com",
                  birthdate: Date.new(rand(1950..1998), rand(1..12), rand(1..28))
end

30.times do |i|
  Item.create title: "Item number #{i + 1}",
              price: rand(0.99..149.99).round(2)
end

items = Item.all
Customer.all.each do |customer|
  order_1 = customer.orders.build number: (0...12).map { [('a'..'z').to_a[rand(26)], rand(0..9)].sample }.join,
                         date: rand(2.years).seconds.ago
  order_1.order_items.build item: items[rand(0..29)], quantity: rand(1..10)
  order_1.save
  order_2 = customer.orders.create number: (0...12).map { [('a'..'z').to_a[rand(26)], rand(0..9)].sample }.join,
                         date: rand(1.year).seconds.ago
  order_2.order_items.build item: items[rand(0..29)], quantity: rand(1..10)
  order_2.save
end
