require 'rails_helper'

RSpec.describe CategoryProduct, type: :model do
  subject(:cat_prod) { build(:category_product, category: category, product: product) }

  let(:category) { create(:category) }
  let(:product) { create(:product) }

  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:product) }

  it "validates uniqueness of category_id scoped to product_id" do
    create(:category_product, category: category, product: product)
    expect(cat_prod).to validate_uniqueness_of(:category_id).scoped_to(:product_id)
  end
end
