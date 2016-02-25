class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :date

  has_one :place, embed: :id
end
