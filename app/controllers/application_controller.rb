class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_csrf_cookie
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private

  def handle_not_found(exception)
    render json: { success: false, error: "Couldn't find #{exception.model}" }, status: :not_found
  end

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-CSRF-Token'])
  end
end
