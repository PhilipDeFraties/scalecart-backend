require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:stock_quantity) }
    it { is_expected.to validate_numericality_of(:stock_quantity).only_integer.is_greater_than_or_equal_to(0) }
    it { is_expected.to have_many(:categories).through(:category_products) }
  end
end
