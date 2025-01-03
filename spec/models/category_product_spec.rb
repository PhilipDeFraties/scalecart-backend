require 'rails_helper'

RSpec.describe CategoryProduct, type: :model do
  let(:category) { create(:category) }
  let(:product) { create(:product) }

  subject { build(:category_product, category: category, product: product) }

  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:product) }

  it "validates uniqueness of category_id scoped to product_id" do
    create(:category_product, category: category, product: product)
    is_expected.to validate_uniqueness_of(:category_id).scoped_to(:product_id)
  end
end
