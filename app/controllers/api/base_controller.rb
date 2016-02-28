class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    render json: { status: 404, detail: "Resource for '#{request.original_fullpath}' could not be found" }, status: 404
  end

  def missing_param_error(exception)
    render json: exception.message, status: 422
  end
end
