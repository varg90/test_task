FactoryBot.define do
  factory :customer do
    sequence(:email) { |i| "user#{i}@example.com" }
    birthdate { Date.new(rand(1950..1999), rand(1..12), rand(1..28)) }
  end

  trait :with_orders do
    after(:create) do |customer|
      customer.orders << create(:order)
    end
  end
end
