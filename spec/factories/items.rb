FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0.1..150.0) }
  end
end
