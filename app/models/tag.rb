class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_many :events_tag
  has_many :events, through: :events_tag
end
