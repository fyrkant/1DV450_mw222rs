class Api::V1::EndUsersController < Api::BaseController
  def authenticate
    email = params[:email].downcase
    password = params[:password]
    end_user = User.find_by(email: email)

    if end_user&.valid_password?(password)
      jwt = encode_jwt(end_user)
      render json: { token: jwt }, status: 201
    else
      render json: { message: "Unable to find a user with those credentials" }, status: 401
    end
  end
end
