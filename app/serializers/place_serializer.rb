class PlaceSerializer < BaseSerializer
  attributes :id, :name, :lat, :lng

  has_many :events, embed: :ids

  link :self do
    "/api/places/#{object.id}"
  end
end
