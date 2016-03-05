require "rails_helper"

RSpec.describe Api::V1::EndUsersController, type: :routing do
  it { expect(post: "/api/auth").to route_to "api/v1/end_users#authenticate" }
end
