class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { customer: "customer", admin: "admin" }, _default: "customer"
end
