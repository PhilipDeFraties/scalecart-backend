require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }
  let(:token) { described_class.encode(payload) }

  describe '.encode' do
    it 'creates a token with an expiration time and JTI' do
      decoded = described_class.decode(token)

      expect(decoded['exp']).to be_present
      expect(decoded['jti']).to be_present
    end
  end

  describe '.decode' do
    context 'with a valid token' do
      it 'returns the payload' do
        decoded = described_class.decode(token)

        expect(decoded).to include('user_id' => 1)
      end
    end

    context 'with an expired token' do
      it 'returns nil' do
        expired_token = described_class.encode(payload, 1.second.ago)
        sleep(2) # Ensure token is expired
        decoded = described_class.decode(expired_token)

        expect(decoded).to be_nil
      end
    end

    context 'with a revoked token' do
      it 'returns nil' do
        decoded_payload = described_class.decode(token)
        JwtDenylist.create!(jti: decoded_payload['jti'], exp: Time.zone.at(decoded_payload['exp']))

        expect(described_class.decode(token)).to be_nil
      end
    end

    context 'with an invalid token' do
      it 'returns nil' do
        invalid_token = 'invalid.token.value'

        expect(described_class.decode(invalid_token)).to be_nil
      end
    end
  end
end
