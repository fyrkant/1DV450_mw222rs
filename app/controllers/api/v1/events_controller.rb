class Api::V1::EventsController < Api::BaseController
  def index
    events = Event.all.order(:date)
    render json: events, status: 200
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: 201
    else
      render json: event.errors, status: 422
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event, status: 200
    else
      render json: event.errors, status: 422
    end
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, status: 200
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    head 204
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :place_id)
  end
end
