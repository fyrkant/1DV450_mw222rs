require "rails_helper"

RSpec.describe "Creating tags" do
  context "with valid api key and credentials" do
    let(:user) { User.create!(email: "mail@test.com", password: "testpass", password_confirmation: "testpass") }
    let(:api_key) { ApiKey.create!(name: "Cool app", user_id: user.id) }
    let(:api_key_header) { { "X-Api-key" => api_key.key } }
    let(:auth_header) do
      post "/api/auth", { email: user.email, password: user.password }, api_key_header

      token = json(response.body)[:token]
      auth_header = api_key_header.merge(
        "Authorization" => "Bearer #{token}",
        "Accept" => "application/json",
        "Content-Type" => "application/json")

      auth_header
    end
    it "creates a tag" do
      post "/api/tags", { tag: tag_attributes }.to_json, auth_header

      expect(response).to have_http_status 201

      tag = json(response.body)[:data]
      expect(tag[:attributes][:name]).to eq tag_attributes[:name]
    end
    it "cannot create tag with missing parameter" do
      post "/api/tags", { tag: { name: nil } }.to_json, auth_header

      expect(response).to have_http_status 422
    end
  end
end

def tag_attributes
  {
    name: "My tag"
  }
end
