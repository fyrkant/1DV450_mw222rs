require "rails_helper"

RSpec.describe "ListingPlaces" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:place2) { Place.create!(name: "Another place", lat: 23.2233, lng: 23.344) }
  let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1) }

  describe "list all places" do
    it "lists all places" do
      get "/api/v1/places"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:places].length).to eq 2
    end
  end
  describe "get single place" do
    it "shows a single place" do
      get "/api/v1/places/#{place1.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:place][:name]).to eq place1.name
    end
    it "returns status 404 when requesting non-existent resource" do
      get "/api/v1/places/2023124235042934"

      expect(response).to have_http_status 404
      expect(response.content_type).to eq Mime::JSON
    end
  end
end
