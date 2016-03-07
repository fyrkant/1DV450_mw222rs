class Api::V1::PlacesController < Api::BaseController
  before_action :authenticate_user!, only: :create
  def index
    places = Place.all
    render json: places, status: 200
  end

  def create
    place = Place.new(place_params)
    if place.save
      render json: place, status: 201
    else
      render json: place.errors, status: 422
    end
  end

  def show
    place = Place.find(params[:id])

    render json: place, status: 200
  end

  private

  def place_params
    params.require(:place).permit(:name, :lat, :lng, :event)
  end
end
