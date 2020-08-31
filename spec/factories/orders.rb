FactoryBot.define do
  factory :order do
    number { (0...12).map { [('a'..'z').to_a[rand(26)], rand(0..9)].sample }.join }
    date { rand(2.years).seconds.ago }
    customer
  end
end
