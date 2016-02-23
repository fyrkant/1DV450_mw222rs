class Api::PlacesController < ApplicationController
  def index
    places = Place.all
    render json: places, status: 200
  end
end
