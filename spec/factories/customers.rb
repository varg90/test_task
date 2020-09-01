FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    birthdate { Faker::Date.birthday(min_age: 21) }
  end

  trait :with_orders do
    after(:create) do |customer|
      customer.orders << create(:order)
    end
  end
end
