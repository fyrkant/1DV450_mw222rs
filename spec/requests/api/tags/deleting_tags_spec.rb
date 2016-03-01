require "rails_helper"

RSpec.describe "Delete tag" do
  let!(:tag1) { Tag.create!(name: "concert") }
  let!(:tag2) { Tag.create!(name: "corporate") }
  it "deletes a tag with post and return correct status" do
    expect(Tag.count).to eq 2

    delete "/api/tags/#{tag1.id}"

    expect(response).to have_http_status 204
    expect(Tag.count).to eq 1
  end
  it "returns 404 when trying to delete something that doesnt exist" do
    delete "/api/tags/9999999"

    expect(response).to have_http_status 404

    errors = json(response.body)
    expect(errors[:status]).to eq 404
    expect(errors[:detail]).to eq "Resource for '/api/tags/9999999' could not be found"
  end
end
