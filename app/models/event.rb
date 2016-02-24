class Event < ActiveRecord::Base
  belongs_to :place

  validates :name, presence: true, length: { in: 5..50 }
  validates :description, presence: true, length: { in: 10..500 }
end
