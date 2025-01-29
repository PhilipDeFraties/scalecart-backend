require 'rails_helper'
require 'json_web_token'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }
  let(:token) { described_class.encode(payload) }

  describe '.encode' do
    it 'returns a valid JWT token' do
      expect(token).not_to be_nil
      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    it 'decodes a valid token' do
      decoded_payload = described_class.decode(token)
      expect(decoded_payload['user_id']).to eq(payload[:user_id])
    end

    it 'returns nil for an invalid token' do
      expect(described_class.decode('invalid_token')).to be_nil
    end

    it 'returns nil for an expired token' do
      expired_token = described_class.encode(payload, 1.second.ago)
      sleep 2
      expect(described_class.decode(expired_token)).to be_nil
    end
  end
end
