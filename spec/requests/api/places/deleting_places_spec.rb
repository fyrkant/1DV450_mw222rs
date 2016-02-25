require "rails_helper"

RSpec.describe "Delete place" do
  let!(:place1) { Place.create!(name: "MyPlace", lat: 34.3432, lng: 142.223) }
  let!(:place2) { Place.create!(name: "MyPlace #2", lat: 34.3432, lng: 142.223) }
  it "deletes a place with a post and returns correct status" do
    expect(Place.count).to eq 2

    delete "/api/places/#{place1.id}"

    expect(response).to have_http_status 204
    expect(Place.count).to eq 1
  end
  it "returns 404 when trying to delete non-existent resource" do
    delete "/api/places/9999999999"

    expect(response).to have_http_status 404

    json = json(response.body)
    expect(json[:status]).to eq 404
    expect(json[:detail]).to eq "Resource for '/api/places/9999999999' could not be found"
  end
end
