require "rails_helper"
RSpec.describe "Rack::Attack", type: :request do
  include ActiveSupport::Testing::TimeHelpers

  before do
    Rack::Attack.enabled = true
    Rack::Attack.reset!
  end

  after do
    Rack::Attack.enabled = false
  end

  describe "POST /login" do
    let(:user) { create(:user, password: 'password123') }
    let(:headers) { { "REMOTE_ADDR" => "1.2.3.4" } }

    it "successful for 5 requests, then blocks the user nicely" do
      5.times do
        post '/login', params: { email: user.email, password: 'password123' }, headers: headers
        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
      end

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
