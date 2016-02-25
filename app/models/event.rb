class Event < ActiveRecord::Base
  belongs_to :place

  validates :date, presence: true
  validates :name, presence: true, length: { in: 5..50 }
  validates :description, presence: true, length: { in: 10..500 }
end
