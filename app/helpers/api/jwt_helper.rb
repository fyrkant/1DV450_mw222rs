module Api::JwtHelper
  class OutdatedTokenError < StandardError; end
  class DecodeError < JWT::DecodeError; end

  def encode_jwt(end_user, expiration=2.hours.from_now)
    payload = { end_user_id: end_user.id, expiration: expiration.to_i }

    JWT.encode(payload, Rails.application.secrets.secret_key_base, "HS512")
  end

  def decode_jwt(headers)
    return if headers.nil?
    token = headers.split.last
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")[0]

    # byebug
    fail OutdatedTokenError unless Time.now.to_i <= payload["expiration"]
    payload[:end_user_id]
  end
end
