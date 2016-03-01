require "rails_helper"

RSpec.describe "Creating tags" do
  it "creates a tag" do
    post "/api/tags", { tag: tag_attributes }.to_json,
         "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 201

    tag = json(response.body)[:data]
    expect(tag[:attributes][:name]).to eq tag_attributes[:name]
  end
  it "cannot create tag with missing parameter" do
    post "/api/tags", { tag: { name: nil } }.to_json,
         "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 422
  end
end

def tag_attributes
  {
    name: "My tag"
  }
end
