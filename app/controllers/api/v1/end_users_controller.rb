class Api::V1::EndUsersController < Api::BaseController
  def authenticate
    email = params[:email].downcase
    password = params[:password]
    end_user = User.find_by(email: email)

    if end_user&.valid_password?(password)
      render json: { token: encode_jwt(end_user) }, status: 201
    else
      render json: { message: "Invalid username or password" }, status: 401
    end
  end
end
