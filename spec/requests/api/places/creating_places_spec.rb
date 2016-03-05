require "rails_helper"

RSpec.describe "Creating places" do
  context "with valid api key and credentials" do
    let(:user) { User.create!(email: "mail@test.com", password: "testpass", password_confirmation: "testpass") }
    let(:api_key) { ApiKey.create!(name: "Cool app", user_id: user.id) }
    let(:api_key_header) { { "X-Api-key" => api_key.key } }

    it "creates a new place" do
      post "/api/places", { place: place_attributes }.to_json,
           "Accept" => "application/json", "Content-Type" => "application/json"

      expect(response).to have_http_status 201

      place = json(response.body)[:data]
      expect(place[:attributes][:name]).to eq place_attributes[:name]
      expect(place[:attributes][:lat].to_f).to eq place_attributes[:lat]
      expect(place[:attributes][:lng].to_f).to eq place_attributes[:lng]
    end
    it "cannot create a place with missing parameters" do
      post "/api/places", { place: { name: nil, lat: 34.43, lng: 2 } }.to_json,
           "Accept" => "application/json", "Content-Type" => "application/json"

      expect(response).to have_http_status 422
    end
  end
end

def place_attributes
  {
    name: "TestingPlace",
    lat: 23.4455,
    lng: 45.444
  }
end
