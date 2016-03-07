class Api::V1::PlacesController < Api::BaseController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    places = Place.all
    render json: places, status: 200
  end

  def create
    place = current_user.places.new(place_params)
    if place.save
      render json: place, status: 201
    else
      render json: place.errors, status: 422
    end
  end

  def update
    place = Place.find(params[:id])
    if place.update(place_params)
      render json: place, status: 200
    else
      render json: place.errors, status: 422
    end
  end

  def show
    place = Place.find(params[:id])

    render json: place, status: 200
  end

  def destroy
    place = Place.find(params[:id])
    place.destroy
    head 204
  end

  private

  def place_params
    params.require(:place).permit(:name, :lat, :lng, :event)
  end
end
