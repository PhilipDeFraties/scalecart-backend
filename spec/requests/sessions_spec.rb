require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  let(:user) { create(:user, password: 'password123') }

  describe 'POST /login' do
    context 'with valid credentials' do
      it 'logs in the user and establishes a session' do
        post '/login', params: { email: user.email, password: 'password123' }, headers: { 'Accept' => 'application/json' }

        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post '/login', params: { email: user.email, password: 'wrongpassword' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Invalid email or password')
      end
    end
  end

  describe 'DELETE /logout' do
    context 'when user is logged in' do
      it 'logs out the user and destroys the session' do
        post '/login', params: { email: user.email, password: 'password123' }
        delete '/logout'

        expect(response).to have_http_status(:no_content)
        expect(session[:user_id]).to be_nil
      end
    end

    context 'when user is not logged in' do
      it 'returns an unauthorized error' do
        delete '/logout'

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Not logged in')
      end
    end
  end
end
