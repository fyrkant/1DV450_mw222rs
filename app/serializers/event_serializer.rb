class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_one :place, embed: :id
end
