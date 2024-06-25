FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Commerce.price(range: 5.0..50.0) }
    status { 0 }
    frequency { Faker::Number.between(from: 1, to: 12) }
    association :customer
    association :tea
  end
end
