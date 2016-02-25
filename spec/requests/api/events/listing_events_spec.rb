require "rails_helper"

RSpec.describe "Listing events" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1, date: rand(300).days.from_now) }
  let!(:event2) { Event.create!(name: "Party two!", description: "Lorem ipsum dolores whatever", place: place1, date: rand(300).days.from_now) }

  describe "list all events" do
    it "lists all events" do
      get "/api/events"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:events].length).to eq 2
    end
  end
  describe "get single event" do
    it "show a single event" do
      get "/api/events/#{event1.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:event][:name]).to eq event1.name
      expect(json[:event][:place_id]).to eq place1.id
    end
    it "returns 404 and error object when requesting non-existent resource" do
      get "/api/events/99999999999999"

      expect(response).to have_http_status 404
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:status]).to eq 404
      expect(json[:detail]).to eq "Resource for '/api/events/99999999999999' could not be found"
    end
  end
end
