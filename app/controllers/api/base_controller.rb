class Api::BaseController < ApplicationController
  include Api::JwtHelper

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_action :destroy_session
  before_action :check_api_key_and_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  private def check_api_key_and_token
    if ApiKey.find_by(key: request.headers["X-Api-key"]).present?
      auth = request.headers["HTTP_AUTHORIZATION"]
      check_token auth if auth
    else
      render json: { status: 401, detail: "Invalid API key." }, status: 401
    end
  end

  private def check_token(token)
    end_user_id = decode_jwt token
    end_user = User.find(end_user_id)
    if end_user
      sign_in(:user, end_user)
    else
      render json: { message: "Invalid credentials" }, status: 401
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
