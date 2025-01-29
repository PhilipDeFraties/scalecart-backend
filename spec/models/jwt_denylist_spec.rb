require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  subject { create(:jwt_denylist, jti: SecureRandom.uuid) }

  it { is_expected.to validate_presence_of(:jti) }
  it { is_expected.to validate_uniqueness_of(:jti) }
end
