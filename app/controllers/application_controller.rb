class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :error_404

  def error_404(e = nil)
    render json: '{"status": "ERROR: Record Not Found"}'
  end
end
