class SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'Logged in successfully' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    if session[:user_id]
      reset_session
      render json: { message: 'Logged out successfully' }, status: :no_content
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end
end
