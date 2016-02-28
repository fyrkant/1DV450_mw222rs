require "rails_helper"

RSpec.describe Api::V1::EventsController, type: :routing do
  it { expect(get: "/api/events").to route_to "api/v1/events#index" }
  it { expect(get: "/api/events?page[number]=1&page[size]=25").to route_to "api/v1/events#index", page: { "number" => "1", "size" => "25" } }
  it { expect(get: "/api/events/1").to route_to "api/v1/events#show", id: "1" }
  it { expect(post: "/api/events").to route_to "api/v1/events#create" }
  it { expect(put: "/api/events/1").to route_to "api/v1/events#update", id: "1" }
  it { expect(delete: "/api/events/1").to route_to "api/v1/events#destroy", id: "1" }
end
