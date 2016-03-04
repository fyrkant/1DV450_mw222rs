require "rails_helper"

RSpec.describe "ListingPlaces" do
  context "without vlaid api key" do
    it "returns 401" do
      get "/api/places"

      expect(response).to have_http_status 401
      expect(response.content_type).to eq Mime::JSON
    end
  end
  context "with valid API key" do

    # TODO: Add api key to header.

    let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
    let!(:place2) { Place.create!(name: "Another place", lat: 23.2233, lng: 23.344) }
    let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1, date: rand(300).days.from_now) }

    describe "list all places" do
      it "lists all places" do
        get "/api/places"

        expect(response).to have_http_status 200
        expect(response.content_type).to eq Mime::JSON

        json = json(response.body)
        expect(json[:data].length).to eq 2
      end
    end
    describe "get single place" do
      it "returns existing resource" do
        get "/api/places/#{place1.id}"

        expect(response).to have_http_status 200
        expect(response.content_type).to eq Mime::JSON

        json = json(response.body)
        expect(json[:data][:attributes][:name]).to eq place1.name
      end
      it "returns 404 and error object when requesting non-existent resource" do
        get "/api/places/2023124235042934"

        expect(response).to have_http_status 404
        expect(response.content_type).to eq Mime::JSON

        json = json(response.body)
        expect(json[:status]).to eq 404
        expect(json[:detail]).to eq "Resource for '/api/places/2023124235042934' could not be found"
      end
    end
  end
end
