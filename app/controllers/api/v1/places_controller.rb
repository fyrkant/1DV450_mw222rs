class Api::V1::PlacesController < Api::V1::BaseController
  def index
    places = Place.all
    render json: places, status: 200
  end

  def show
    place = Place.find(params[:id])

    render json: place, status: 200
  end
end
