FactoryBot.define do
  factory :order_item do
    order
    item
    quantity { 1.0 }
  end
end
