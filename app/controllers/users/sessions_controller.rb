module Users
  class SessionsController < Devise::SessionsController
    before_action :ensure_json_request
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if current_user
        render json: {
          message: "You are already logged in",
          token: current_token
        }, status: :ok
      elsif resource.persisted?
        render json: {
          message: "Logged in successfully",
          token: current_token
        }, status: :ok
      else
        render json: { error: "Invalid Email or password" }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      if current_user
        render json: { message: "Logged out successfully" }, status: :no_content
      else
        render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
      end
    end

    def current_token
      request.env['warden-jwt_auth.token']
    end

    def ensure_json_request
      request.format = :json
    end
  end
end
