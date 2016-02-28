class EventSerializer < BaseSerializer
  attributes :id, :name, :description, :date
  belongs_to :place, embed: :id
  has_many :tags, embed: :ids

  link :self do
    "/api/events/#{object.id}"
  end
end
