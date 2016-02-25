class TagSerializer < BaseSerializer
  attributes :id, :name

  has_many :events, embed: :ids

  link :self do
    "/api/places/#{object.id}"
  end
end
