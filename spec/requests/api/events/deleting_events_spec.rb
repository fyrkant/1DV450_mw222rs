require "rails_helper"

RSpec.describe "Delete event" do
  let!(:event1) { Event.create!(name: "My cool event #1", description: "Lorem ipsum dolor sit amet, consectetur.") }
  let!(:event2) { Event.create!(name: "My cool event #2", description: "Lorem ipsum dolor sit amet, consectetur adipisicing.") }
  it "deletes a Event with a post and returns correct status" do
    expect(Event.count).to eq 2

    delete "/api/events/#{event1.id}"

    expect(response).to have_http_status 204
    expect(Event.count).to eq 1
  end
  it "returns 404 when trying to delete non-existent resource" do
    delete "/api/events/9999999999"

    expect(response).to have_http_status 404

    json = json(response.body)
    expect(json[:status]).to eq 404
    expect(json[:detail]).to eq "Resource for '/api/events/9999999999' could not be found"
  end
end
