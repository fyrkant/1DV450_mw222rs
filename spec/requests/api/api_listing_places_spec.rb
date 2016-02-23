require "rails_helper"

RSpec.describe "ListingPlaces" do
  before do
    Place.create!(
      [
        { name: "Some place", lat: 12.34, lng: 34.45 },
        { name: "Another place", lat: 23.2233, lng: 23.344 }
      ])
  end
  describe "list all places" do
    it "lists all places" do
      get "/api/places"

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status 200
      expect(json.length).to eq 2
    end
  end
end
