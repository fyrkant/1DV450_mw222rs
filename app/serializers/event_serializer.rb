class EventSerializer < BaseSerializer
  attributes :id, :name, :description, :date

  belongs_to :place, embed: :id
  has_many :tags

  link :self do
    "/api/events/#{object.id}"
  end
  link :place do
    "/api/places/#{object.place_id}"
  end
end
