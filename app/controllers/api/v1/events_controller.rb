class Api::V1::EventsController < Api::BaseController
  before_action :set_pagination_vars, only: :index
  def index
    events = Event.search(params[:search])
                  .tagged(params[:tag])
                  .order(:date)
                  .page(@number).per(@size)

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
    event = Event.find(params[:id])
    render json: event, include: "*", status: 200
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    head 204
  end

  private

  def set_pagination_vars
    if params[:page]
      @number = params[:page][:number]
      @size = params[:page][:size]
    else
      @number = 1
      @size = Event.count
    end
  end

  def event_params
    params.require(:event).permit(:name, :description, :date, :place_id)
  end
end
