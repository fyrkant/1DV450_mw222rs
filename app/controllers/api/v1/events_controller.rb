class Api::V1::EventsController < Api::BaseController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pagination_vars, only: :index
  def index
    events = Event.search(params[:search])
                  .tagged(params[:tag_id])
                  .order(:date)
                  .page(@number).per(@size)

    render json: events, location: "hello", status: 200
  end

  def create
    event = current_user.events.new(event_params)
    tag_params&.each do |t|
      tag = Tag.find_by(id: t)
      event.tags << tag
    end
    if event.save
      render json: event, status: 201
    else
      render json: event.errors, status: 422
    end
  end

  def update
    event = current_user.events.find(params[:id])
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
    event = current_user.events.find(params[:id])
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
    params.require(:event).permit(:name, :description, :date, :tags, :place_id)
  end

  def tag_params
    params.permit(tags: [])[:tags]
  end
end
