class Api::V1::TagsController < Api::BaseController
  def index
    tags = Tag.all
    render json: tags, status: 200
  end

  def show
    tag = Tag.find(params[:id])
    render json: tag, status: 200
  end

  def create
    tag = Tag.new(tag_params)
    if tag.save
      render json: tag, status: 201
    else
      render json: tag.errors, status: 422
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      render json: tag, status: 200
    else
      render json: tag.errors, status: 422
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head 204
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
