class ApplicationController < ActionController::API
  include ApiResponse
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private

  def handle_not_found(exception)
    render_error("Couldn't find #{exception.model}", status: :not_found)
  end
end
