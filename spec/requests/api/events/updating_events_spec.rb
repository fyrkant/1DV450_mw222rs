require "rails_helper"

RSpec.describe "Updating events" do
  context "with valid api key and credentials" do
    let(:user) { User.create!(email: "mail@test.com", password: "testpass", password_confirmation: "testpass") }
    let(:api_key) { ApiKey.create!(name: "Cool app", user_id: user.id) }
    let(:api_key_header) { { "X-Api-key" => api_key.key } }
    let(:auth_header) do
      post "/api/auth", { email: user.email, password: user.password }, api_key_header

      token = json(response.body)[:token]
      auth_header = api_key_header.merge(
        "Authorization" => "Bearer #{token}",
        "Accept" => "application/json",
        "Content-Type" => "application/json")

      auth_header
    end

    let!(:place) { Place.create!(name: "TestingPlace", lat: 23, lng: 32) }
    let!(:event) do
      Event.create!(
        name: "Cool event",
        description: "my awesome event is awesome",
        date: 3.days.from_now,
        place_id: place.id,
        user_id: user.id)
    end
    it "updates an event" do
      put "/api/events/#{event.id}",
          {
            event: {
              name: "NewName",
              description: event.description,
              date: 3.days.from_now,
              place_id: event.place_id }
          }.to_json,
          auth_header

      expect(response).to have_http_status 200
      event.reload
      expect(event.name).to eq "NewName"
    end
    it "updates with patch also" do
      put "/api/events/#{event.id}",
          {
            event: {
              description: "My new cool description."
            }
          }.to_json,
          auth_header

      expect(response).to have_http_status 200
      event.reload
      expect(event.description).to eq "My new cool description."
    end
    it "fails on update with missing parameters" do
      put "/api/events/#{event.id}",
          {
            event: {
              name: nil
            }
          }.to_json,
          auth_header

      expect(response).to have_http_status 422
      errors = json(response.body)
      expect(errors[:name]).to include "can't be blank"
    end
  end
end
