require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  it { is_expected.to respond_to(:jti) }
  it { is_expected.to respond_to(:expired_at) }

  it 'uses the denylist revocation strategy' do
    expect(JwtDenylist.ancestors).to include(Devise::JWT::RevocationStrategies::Denylist)
  end
end
