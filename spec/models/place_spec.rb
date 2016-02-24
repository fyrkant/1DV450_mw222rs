require "rails_helper"

RSpec.describe Place, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }

  it "lat a number between -90 and 90" do
    should validate_numericality_of(:lat)
      .is_greater_than_or_equal_to(-90)
      .is_less_than_or_equal_to(90)
  end

  it "lng is a number between -180 and 180" do
    should validate_numericality_of(:lng)
      .is_greater_than_or_equal_to(-180)
      .is_less_than_or_equal_to(180)
  end
end
