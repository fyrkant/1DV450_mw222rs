class BaseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # link :tags do
  #   "/api/tags/"
  # end
  # link :events do
  #   "/api/events/"
  # end
  # link :places do
  #   "/api/places/"
  # end
end
