class EventSerializer < BaseSerializer
  attributes :id, :name, :description, :date
  belongs_to :user, embed: :id
  belongs_to :place, embed: :id
  has_many :tags, embed: :ids

  link :self do
    "/api/events/#{object.id}"
  end

  class UserSerializer < BaseSerializer
    attributes :id
  end
end
