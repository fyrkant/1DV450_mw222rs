class Api::V1::EventsController < Api::V1::BaseController
  def index
    @events = Event.all
    render json: @events, status: 200
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, status: 200
  end
end
