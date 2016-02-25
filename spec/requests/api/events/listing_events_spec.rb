require "rails_helper"

RSpec.describe "Listing events" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1, date: 10.day.from_now) }
  let!(:event2) { Event.create!(name: "Party two!", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }

  describe "list all events" do
    it "lists all events" do
      get "/api/events"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:data].length).to eq 2
    end
  end
  it "sorts events on date" do
    get "/api/events"

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    events = json(response.body)[:data]

    expect(events.first[:attributes][:name]).to eq "Party two!"
  end
  describe "get single event" do
    it "show a single event" do
      get "/api/events/#{event1.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:data][:attributes][:name]).to eq event1.name
      expect(json[:data][:relationships][:place][:data][:id].to_i).to eq place1.id
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
