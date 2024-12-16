require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new(name: "Electronics") }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to belong_to(:parent_category).optional }
  it { is_expected.to have_many(:subcategories).dependent(:destroy) }
end
