class SessionsController < ApplicationController
  before_action :authorize_request, only: [:logout]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token)

    if decoded_token
      JwtDenylist.create!(jti: decoded_token['jti'], exp: Time.zone.at(decoded_token['exp']))
      render json: { message: 'Logged out successfully' }, status: :no_content
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def authorize_request
    token = request.headers['Authorization']&.split(' ')&.last
    @current_user = User.find(JsonWebToken.decode(token)['user_id']) if token
  rescue JWT::DecodeError, JWT::ExpiredSignature, ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
