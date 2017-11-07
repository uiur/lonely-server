class ImagesController < ApplicationController
  before_action :set_space
  before_action :require_user, only: [:index, :latest]
  before_action :require_permission, only: [:index, :latest]

  PER_PAGE = 20

  def create
    image = @space.images.create!(timestamp: Time.at(params[:timestamp].to_i))

    render json: {
      timestamp: image.timestamp.to_i
    }, status: :created
  end

  def index
    @images = @space.images.order(timestamp: :desc).limit(PER_PAGE)

    respond_to do |format|
      format.html { render :index }
    end
  end

  def latest
    @image = @space.images.order(timestamp: :desc).first

    respond_to do |format|
      format.html do
        redirect_to @image.s3_object.presigned_url(:get), status: :found
      end
      format.json
    end
  end

  private
  def set_space
    @space = Space.find_by!(name: params[:name])
  end

  def require_permission
    unless @space.viewable_by?(current_user)
      raise Error::Forbidden
    end
  end
end
