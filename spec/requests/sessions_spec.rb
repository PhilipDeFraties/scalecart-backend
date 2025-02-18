require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  let(:user) { create(:user) }
  let(:valid_credentials) { { email: user.email, password: user.password } }
  let(:invalid_credentials) { { email: 'wrong@example.com', password: 'wrongpassword' } }

  describe 'POST /login' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post '/login', params: valid_credentials, headers: { Accept: 'application/json' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post '/login', params: invalid_credentials, headers: { Accept: 'application/json' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'DELETE /logout' do
    context 'with a valid JWT token' do
      it 'revokes the JWT token' do
        post '/login', params: valid_credentials, headers: { Accept: 'application/json' }
        token = JSON.parse(response.body)['token']

        delete '/logout', headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:no_content)
        decoded_token = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'), true, algorithm: 'HS256')[0]['jti']
        expect(JwtDenylist.exists?(jti: decoded_token)).to be true
      end
    end

    context 'without a JWT token' do
      it 'returns an unauthorized error' do
        delete '/logout'

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid token')
      end
    end
  end
end
