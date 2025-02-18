class User < ApplicationRecord
  has_secure_password

  enum :role, { customer: "customer", admin: "admin" }, default: "customer"

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end