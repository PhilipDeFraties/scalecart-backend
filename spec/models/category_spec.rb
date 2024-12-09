require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new(name: "Electronics") }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should belong_to(:parent_category).optional }
  it { should have_many(:subcategories).dependent(:destroy) }
end
