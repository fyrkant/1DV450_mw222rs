require "rails_helper"

RSpec.describe "Updating places" do
  let!(:place) { Place.create!(name: "TestingPlace", lat: 23, lng: 32) }
  let!(:event) { Event.create!(name: "Cool event", description: "my awesome event is awesome") }
  it "updates a place" do
    put "/api/places/#{place.id}", { place: { name: "NewName", lat: 23, lng: 32 } }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 200
    place.reload
    expect(place.name).to eq "NewName"
  end
  it "updates a place with patch also" do
    patch "/api/places/#{place.id}", { place: { name: "PatchedName" } }.to_json,
          "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 200
    place.reload
    expect(place.name).to eq "PatchedName"
    expect(place.lat).to eq 23
    expect(place.lng).to eq 32
  end
  it "fails on update with missing parameters" do
    put "/api/places/#{place.id}", { place: { name: nil, lat: 23, lng: 32} }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 422
  end
end
