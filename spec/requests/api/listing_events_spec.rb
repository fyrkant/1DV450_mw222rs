require "rails_helper"

RSpec.describe "Listing events" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1) }
  let!(:event2) { Event.create!(name: "Party two!", description: "Lorem ipsum dolores whatever", place: place1) }

  describe "list all events" do
    it "lists all events" do
      get "/api/v1/events"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:events].length).to eq 2
    end
  end
  describe "get single event" do
    it "show a single event" do
      get "/api/v1/events/#{event1.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:event][:name]).to eq event1.name
      expect(json[:event][:place]).to eq place1.id
    end
  end
end
