class Place < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
  # validates :lat, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  # validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  geocoded_by :name, latitude: :lat, longitude: :lng
  after_validation :geocode
end
