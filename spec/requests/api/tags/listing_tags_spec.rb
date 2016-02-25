require "rails_helper"

RSpec.describe "Lists all tags" do
  let!(:tag1) { Tag.create!(name: "concert") }
  let!(:tag2) { Tag.create!(name: "corporate") }
  it "lists all tags" do
    get "/api/tags"

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    tags = json(response.body)[:data]
    expect(tags.size).to eq 2
  end
  it "lists a single tag" do
    get "/api/tags/#{tag1.id}"

    expect(response).to have_http_status 200
    expect(response.content_type).to eq Mime::JSON

    tag = json(response.body)[:data]
    expect(tag[:attributes][:name]).to eq tag1.name
  end
  it "returns 404 when request non-existent resource" do
    get "/api/tags/9999999999"

    expect(response).to have_http_status 404
    expect(response.content_type).to eq Mime::JSON

    error = json(response.body)

    expect(error[:status]).to eq 404
    expect(error[:detail]).to eq "Resource for '/api/tags/9999999999' could not be found"
  end
end
