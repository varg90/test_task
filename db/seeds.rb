# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
30.times do |i|
  Customer.create email: "user#{i + 1}@example.com",
                  birthdate: Date.new(rand(1950..2000), rand(1..12), rand(1..28))
end
