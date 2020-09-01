FactoryBot.define do
  factory :order do
    number { Faker::Commerce.promotion_code }
    date { Faker::Date.backward(days: 30) }
    customer
  end
end
