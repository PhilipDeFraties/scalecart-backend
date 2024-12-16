class Category < ApplicationRecord
  has_many :subcategories,
           class_name: "Category",
           foreign_key: "parent_id",
           dependent: :destroy,
           inverse_of: :parent_category

  belongs_to :parent_category,
             class_name: "Category",
             foreign_key: "parent_id",
             optional: true,
             inverse_of: :subcategories

  validates :name, presence: true, uniqueness: true
end
