require "rails_helper"

RSpec.describe "ListingPlaces" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:place2) { Place.create!(name: "Another place", lat: 23.2233, lng: 23.344) }

  describe "list all places" do
    it "lists all places" do
      get "/api/places"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:places].length).to eq 2
    end
  end
  describe "get single place" do
    it "show a single place" do
      get "/api/places/#{place1.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:name]).to eq place1.name
    end
  end
end
