require "rails_helper"

RSpec.describe "Creating places" do
  it "creates a new place" do
    post "/api/places", { place: place_attributes }.to_json,
         "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 201

    place = json(response.body)[:place]
    expect(place[:name]).to eq place_attributes[:name]
    expect(place[:lat].to_f).to eq place_attributes[:lat]
    expect(place[:lng].to_f).to eq place_attributes[:lng]
  end
  it "cannot create a place with missing parameters" do
    post "/api/places", { place: { name: nil, lat: 34.43, lng: 2 } }.to_json,
         "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 422
  end
end

def place_attributes
  {
    name: "TestingPlace",
    lat: 23.4455,
    lng: 45.444
  }
end
