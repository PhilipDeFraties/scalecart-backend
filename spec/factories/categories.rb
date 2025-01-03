FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    parent_category { nil }
  end
end
