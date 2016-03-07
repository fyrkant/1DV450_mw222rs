require "rails_helper"

RSpec.describe "Listing events" do
  let!(:place1) { Place.create!(name: "Some place", lat: 12.34, lng: 34.45) }
  let!(:event1) { Event.create!(name: "Party!", description: "Lorem ipsum dolores whatever", place: place1, date: 10.days.from_now) }
  let!(:event2) { Event.create!(name: "Party two!", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }
  let!(:event3) { Event.create!(name: "Taco party!", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }
  let!(:event4) { Event.create!(name: "Fiesta una sushi", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }
  let!(:event5) { Event.create!(name: "Bonenkai", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }
  let!(:event6) { Event.create!(name: "Birthday party", description: "Lorem ipsum dolores whatever", place: place1, date: 7.days.from_now) }

  let(:user) { User.create!(email: "mail@test.com", password: "testpass", password_confirmation: "testpass") }
  let(:api_key) { ApiKey.create!(name: "Cool app", user_id: user.id) }
  let(:api_key_header) { { "X-Api-key" => api_key.key } }

  describe "list all events" do
    it "lists all events" do
      get "/api/events", {}, api_key_header

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:data].length).to eq 6
    end
  end
  it "sorts events on date" do
    get "/api/events", {}, api_key_header

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    events = json(response.body)[:data]

    expect(events.first[:attributes][:name]).to eq "Party two!"
  end
  it "searches with search query string" do
    get "/api/events?search=party", {}, api_key_header

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    json = json(response.body)
    expect(json[:data].length).to eq 4
  end
  it "is a fuzzy search" do
    get "/api/events?search=arty", {}, api_key_header

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    json = json(response.body)
    expect(json[:data].length).to eq 4
  end
  describe "get single event" do
    it "show a single event" do
      get "/api/events/#{event1.id}", {}, api_key_header

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:data][:attributes][:name]).to eq event1.name
      expect(json[:data][:relationships][:place][:data][:id].to_i).to eq place1.id
    end
    it "returns 404 and error object when requesting non-existent resource" do
      get "/api/events/99999999999999", {}, api_key_header

      expect(response).to have_http_status 404
      expect(response.content_type).to eq Mime::JSON

      json = json(response.body)
      expect(json[:status]).to eq 404
      expect(json[:detail]).to eq "Resource for '/api/events/99999999999999' could not be found"
    end
  end
end
