class ImagesController < ApplicationController
  before_action :set_space
  before_action :require_user, only: [:latest]
  before_action :require_permission, only: [:latest]

  def create
    image = @space.images.create!(timestamp: Time.at(params[:timestamp].to_i))

    render json: { 
      timestamp: image.timestamp.to_i
    }, status: :created
  end

  def latest
    latest_image = @space.images.order(timestamp: :desc).first

    redirect_to latest_image.s3_object.presigned_url(:get), status: :found
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
