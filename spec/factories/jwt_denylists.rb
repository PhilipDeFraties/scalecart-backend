FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2025-01-29 16:27:15" }
  end
end
