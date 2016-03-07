require "rails_helper"

RSpec.describe "Delete event" do
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

    let!(:event1) { Event.create!(name: "My cool event #1", description: "Lorem ipsum dolor sit amet, consectetur.", date: rand(300).days.from_now, user_id: user.id) }
    let!(:event2) { Event.create!(name: "My cool event #2", description: "Lorem ipsum dolor sit amet, consectetur adipisicing.", date: rand(300).days.from_now, user_id: user.id) }
    it "deletes a Event with a post and returns correct status" do
      expect(Event.count).to eq 2

      delete "/api/events/#{event1.id}", {}, auth_header

      expect(response).to have_http_status 204
      expect(Event.count).to eq 1
    end
    it "returns 404 when trying to delete non-existent resource" do
      delete "/api/events/9999999999", {}, auth_header

      expect(response).to have_http_status 404

      json = json(response.body)
      expect(json[:status]).to eq 404
      expect(json[:detail]).to eq "Resource for '/api/events/9999999999' could not be found"
    end
  end
end
