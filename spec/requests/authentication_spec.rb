require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

  describe 'POST /users/sign_in' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        headers = { Accept: 'application/json', 'Content-Type' => 'application/json' }
        post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, headers: { Accept: 'application/json' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post '/users/sign_in', params: { user: { email: 'wrong@example.com', password: 'wrongpassword' } }

        expect(response).to have_http_status(:unauthorized)
        body = JSON.parse(response.body)
        expect(body['error']).to eq('Invalid Email or password.')
      end
    end

    context 'when already logged in' do
      it 'returns a message indicating the user is already logged in' do
        headers = { Accept: 'application/json', 'Content-Type' => 'application/json' }
        post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, headers: { Accept: 'application/json' }
        token = JSON.parse(response.body)['token']

        post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, headers: { Accept: 'application/json' }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['message']).to eq('You are already logged in')
        expect(body).to have_key('token')
      end
    end
  end

  describe 'DELETE /users/sign_out' do
    context 'with a valid JWT token' do
      it 'revokes the JWT token' do
        headers = { Accept: 'application/json', 'Content-Type' => 'application/json' }
        post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, headers: { Accept: 'application/json' }

        token = JSON.parse(response.body)['token']
        expect(token).not_to be_nil

        jti = JWT.decode(token, nil, false).first['jti']
        expect(jti).not_to be_nil

        delete '/users/sign_out', headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:no_content)
        expect(JwtDenylist.exists?(jti: jti)).to be true
      end
    end

    context 'without a JWT token' do
      it 'returns an unauthorized error' do
        delete '/users/sign_out'

        expect(response).to have_http_status(:unauthorized)
        body = JSON.parse(response.body)
        expect(body['error']).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end
end