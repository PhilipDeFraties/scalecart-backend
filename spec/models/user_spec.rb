require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid-email').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe 'secure password' do
    it 'encrypts the password' do
      user = create(:user, password: 'password123', password_confirmation: 'password123')
      expect(user.authenticate('password123')).to be_truthy
      expect(user.authenticate('wrongpassword')).to be_falsey
    end
  end

  describe 'enum role' do
    it 'defaults to customer' do
      user = create(:user)
      expect(user.role).to eq('customer')
    end
  end
end
