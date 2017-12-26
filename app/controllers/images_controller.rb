class ImagesController < ApplicationController
  before_action :set_space
  before_action :require_viewable, only: [:index, :latest]

  PER_PAGE = 20

  def index
    step_in_minute = params[:step_in_minute]&.to_i || 1

    @images = @space.images
      .order(timestamp: :desc)
      .where('mod(extract(minute from timestamp)::integer, ?) = 0', step_in_minute)
      .page(params[:page]&.to_i || 1)
      .per(params[:per_page]&.to_i || PER_PAGE)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def latest
    @image = @space.images.order(timestamp: :desc).first!

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
