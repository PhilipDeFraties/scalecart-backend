FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 1.0..100.0) }
    stock_quantity { Faker::Number.between(from: 1, to: 50) }
  end
end
