class BaseSerializer < ActiveModel::Serializer
  link :tags do
    "/api/tags/"
  end
  link :events do
    "/api/events/"
  end
  link :places do
    "/api/places/"
  end
end
