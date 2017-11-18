class Api::ImagesController < Api::ApplicationController
  def create
    image = current_device.space.images.create!(timestamp: Time.at(params[:timestamp].to_i))

    render json: {
      timestamp: image.timestamp.to_i
    }, status: :created
  end
end
