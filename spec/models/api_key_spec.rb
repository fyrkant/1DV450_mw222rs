require "rails_helper"

RSpec.describe ApiKey, type: :model do
  it { should validate_presence_of :name }
  it { should belong_to :user }
end
