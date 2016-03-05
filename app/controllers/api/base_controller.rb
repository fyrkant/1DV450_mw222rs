class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session
  before_action :check_api_key
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  private def check_api_key
    if ApiKey.find_by(key: request.headers["X-Api-key"]).present?
    else
      render json: { status: 401, detail: "Invalid API key." }, status: 401
    end
  end

  private def destroy_session
    request.session_options[:skip] = true
  end

  private def not_found
    render json: { status: 404, detail: "Resource for '#{request.original_fullpath}' could not be found" }, status: 404
  end

  private def missing_param_error(exception)
    render json: exception.message, status: 422
  end
end
