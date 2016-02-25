require "rails_helper"

RSpec.describe "Lists all tags" do
  let!(:tag1) { Tag.create!(name: "concert") }
  let!(:tag2) { Tag.create!(name: "corporate") }
  it "lists all tags" do
    get "/api/tags"

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    tags = json(response.body)
    expect(tags.size).to eq 2
  end
end
