require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "Validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "Database" do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "Roles" do
    it "assigns a default role if not specified" do
      user = described_class.new(email: "test@example.com", password: "password")
      expect(user.role).to eq("customer")
    end
  end
end
