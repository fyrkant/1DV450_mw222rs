module Api::JwtHelper
  def encode_jwt(end_user, expiration=2.hours.from_now)
    payload = { end_user_id: end_user.id, expiration: expiration.to_i }

    JWT.encode(payload, Rails.application.secrets.secret_key_base, "HS512")
  end

  def decode_jwt(token)
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")

    fail "Old token!" unless payload[0]["expiration"] <= Time.now.to_i

    payload
  end
end
