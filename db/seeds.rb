# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all

30.times do |i|
  Customer.create email: "user#{i + 1}@example.com",
                  birthdate: Date.new(rand(1950..2000), rand(1..12), rand(1..28))
end

Customer.all.each do |customer|
  customer.orders.create number: (0...12).map { [('a'..'z').to_a[rand(26)], rand(0..9)].sample }.join,
                         date: rand(2.years).seconds.ago
  customer.orders.create number: (0...12).map { [('a'..'z').to_a[rand(26)], rand(0..9)].sample }.join,
                         date: rand(1.year).seconds.ago
end
