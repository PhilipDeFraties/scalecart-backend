require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  include ActiveSupport::Testing::TimeHelpers
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

    context 'when login attempts exceed the limit' do
      it 'returns a too many requests error' do
        headers = {"REMOTE_ADDR" => "1.2.3.4"}

        5.times do
          post '/login', params: { email: user.email, password: 'password123' }, headers: headers
        end

        post '/login', params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
        delete '/logout'

        post '/login', params: { email: user.email, password: 'password123' }, headers: headers

        expect(response.body).to include('Too many login attempts. Please try again later.')
        expect(response).to have_http_status(:too_many_requests)

        travel_to(10.minutes.from_now) do
          post '/login', params: { email: user.email, password: 'password123' }, headers: headers

          expect(response).to have_http_status(:ok)
          expect(session[:user_id]).to eq(user.id)
        end
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
