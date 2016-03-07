require "rails_helper"

RSpec.describe "Lists all tags" do
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
    let!(:tag1) { Tag.create!(name: "concert") }
    let!(:tag2) { Tag.create!(name: "codeconf") }
    let!(:event1) { Event.create!(name: "Lollapalooza", description: "Lorem ipsum dolor sit amet.", date: 2.months.from_now, tags: [] << tag1) }
    let!(:event2) { Event.create!(name: "Woodstock", description: "Lorem ipsum dolor sit amet.", date: 2.months.from_now, tags: [] << tag1) }
    let!(:event3) { Event.create!(name: "RubyConf", description: "Lorem ipsum dolor sit amet.", date: 2.months.from_now, tags: [] << tag2) }
    it "lists all tags" do
      get "/api/tags", {}, auth_header

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      tags = json(response.body)[:data]
      expect(tags.size).to eq 2
    end
    it "lists a single tag" do
      get "/api/tags/#{tag1.id}", {}, auth_header

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      tag = json(response.body)[:data]
      expect(tag[:attributes][:name]).to eq tag1.name
    end
    it "lists tagges events" do
      get "/api/tags/#{tag1.id}/events", {}, auth_header

      expect(response).to have_http_status 200
      expect(response.content_type).to eq Mime::JSON

      events = json(response.body)[:data]
      expect(events.size).to eq 2
    end
    it "returns 404 when request non-existent resource" do
      get "/api/tags/9999999999", {}, auth_header

      expect(response).to have_http_status 404
      expect(response.content_type).to eq Mime::JSON

      error = json(response.body)

      expect(error[:status]).to eq 404
      expect(error[:detail]).to eq "Resource for '/api/tags/9999999999' could not be found"
    end
  end
end
