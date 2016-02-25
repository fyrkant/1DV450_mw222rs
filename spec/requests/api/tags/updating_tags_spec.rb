require "rails_helper"

RSpec.describe "Updating tags" do
  let!(:tag) { Tag.create!( name: "concert") }
  it "updates a tag" do
    put "/api/tags/#{tag.id}", { tag: { name: "metal-concert"} }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 200
    tag.reload
    expect(tag.name).to eq "metal-concert"
  end
  it "updates a tag with patch also" do
    patch "/api/tags/#{tag.id}", { tag: { name: "PatchedName" } }.to_json,
          "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 200
    tag.reload
    expect(tag.name).to eq "PatchedName"
  end
  it "fails on update with missing parameters" do
    put "/api/tags/#{tag.id}", { tag: { name: nil } }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"

    expect(response).to have_http_status 422
    errors = json(response.body)
    expect(errors[:name]).to include "can't be blank"
  end

end
