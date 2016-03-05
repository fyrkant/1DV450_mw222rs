require "rails_helper"
require "jwt"

RSpec.describe "Authenticate user and get JWT" do
  context "with valid api key" do
    let(:user) { User.create!(email: "mail@test.com", password: "testpass", password_confirmation: "testpass") }
    let(:api_key) { ApiKey.create!(name: "Cool app", user_id: user.id) }
    let(:api_key_header) { { "X-Api-key" => api_key.key } }

    let(:end_user) { User.create!(email: "endusermail@test.com", password: "testpass", password_confirmation: "testpass") }

    it "returns a JWT when correct user credentials are passed in" do
      post "/api/auth", { email: end_user.email, password: end_user.password }, api_key_header

      expect(response).to have_http_status 201
      json = json(response.body)

      decoded_token = JWT.decode(json[:token], Rails.application.secrets.secret_key_base)
      # byebug
      expect(decoded_token[0]["end_user_id"].to_i).to eq end_user.id
    end
    it "returns a 401 with bad credentials" do
      post "/api/auth", { email: end_user.email, password: "not valid pass" }, api_key_header

      expect(response).to have_http_status 401
      expect(response.content_type).to eq Mime::JSON

      error = json(response.body)[:message]

      expect(error).to eq "Unable to find a user with those credentials"
    end
  end
end
