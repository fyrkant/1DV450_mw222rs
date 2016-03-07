class Event < ActiveRecord::Base
  scope :search, ->(keyword) { where("name ILIKE ?", "%#{keyword.downcase}%") if keyword.present? }
  scope :tagged, ->(tag_id) { joins(:tags).where("tags.id = ?", tag_id) if tag_id.present? }

  belongs_to :place
  belongs_to :user
  has_many :events_tag
  has_many :tags, through: :events_tag

  validates :date, presence: true
  validates :name, presence: true, length: { in: 5..50 }
  validates :description, presence: true, length: { in: 10..500 }
end
