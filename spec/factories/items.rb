FactoryBot.define do
  factory :item do
    sequence(:title) { |i| "Item ##{i}" }
    price { rand(0.99..149.99).round(2) }
  end
end
