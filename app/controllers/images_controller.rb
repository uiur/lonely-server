class ImagesController < ApplicationController
  before_action :set_space
  before_action :require_viewable, only: [:index, :latest]

  PER_PAGE = 20

  def index
    @images = @space.images.order(timestamp: :desc).limit(PER_PAGE)

    @recent_face_images = Image
      .eager_load(:image_metadata)
      .where('image_metadata is not null and image_metadata.value is not null')
      .order(timestamp: :desc)
      .limit(4)

    respond_to do |format|
      format.html { render :index }
    end
  end

  def latest
    @image = @space.images.order(timestamp: :desc).first

    respond_to do |format|
      format.html do
        redirect_to @image.url, status: :found
      end
      format.json
    end
  end

  private
  def set_space
    @space = Space.find_by!(name: params[:name])
  end
end
