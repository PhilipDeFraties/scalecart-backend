class Category < ApplicationRecord
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id", optional: true

  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true
end
