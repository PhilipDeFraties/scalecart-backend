class User < ApplicationRecord
  has_secure_password

  enum role: { customer: "customer", admin: "admin" }, _default: "customer"

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
