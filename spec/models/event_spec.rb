require "rails_helper"

RSpec.describe Event, type: :model do
  it { should belong_to :place }
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(5).is_at_most(50) }
  it { should validate_presence_of :description }
  it { should validate_length_of(:description).is_at_least(10).is_at_most(500) }
end
