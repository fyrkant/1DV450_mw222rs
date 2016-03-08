require "rails_helper"

RSpec.describe "Creating places" do
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

    it "creates a new place" do
      post "/api/places", { place: { name: "Umeå" } }.to_json,
           auth_header

      expect(response).to have_http_status 201

      place = json(response.body)[:data]
      expect(place[:attributes][:name]).to eq place_attributes[:name]
      expect(place[:attributes][:lat].to_f.round(2)).to eq place_attributes[:lat]
      expect(place[:attributes][:lng].to_f.round(2)).to eq place_attributes[:lng]
    end
    it "cannot create a place with missing parameters" do
      post "/api/places", { place: { name: nil, lat: 34.43, lng: 2 } }.to_json,
           auth_header

      expect(response).to have_http_status 422
    end
  end
end

def place_attributes
  {
    name: "Umeå",
    lat: 63.83,
    lng: 20.26
  }
end
