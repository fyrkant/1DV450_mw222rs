require "rails_helper"

RSpec.describe "Creating events" do
  before { @place = Place.create!(name: "MyCoolPlace", lat: 23, lng: -123) }
  it "creates a new event" do
    post "/api/events", { event: event_attributes }.to_json,
         "Accept" => "application/json",
         "Content-Type" => "application/json"
    expect(response).to have_http_status 201

    event = json(response.body)[:event]
    expect(event[:name]).to eq event_attributes[:name]
    expect(event[:description]).to eq event_attributes[:description]
    expect(event[:place_id]).to eq event_attributes[:place_id]
  end
  it "fails when parameter is missing" do
    post "/api/events", { event: { name: "TestingEvent", description: nil } }.to_json,
         "Accept" => "application/json",
         "Content-Type" => "application/json"

    expect(response).to have_http_status 422
  end
end

def event_attributes
  {
    name: "Testing event name",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur quidem unde veritatis aspernatur, laudantium architecto reiciendis ipsam, laboriosam qui blanditiis cupiditate nisi assumenda dolore quod neque quia aliquam dolor repellendus.",
    place_id: @place.id
  }
end
