class UploadsController < ApplicationController
  def create
    space = Space.find_by!(name: params[:name])

    timestamp = Time.now
    obj = Image.new(space: space, timestamp: timestamp).s3_object
    @presigned_url = obj.presigned_url(:put, content_type: 'image/jpeg')

    render json: {
      timestamp: timestamp.to_i,
      presigned_url: @presigned_url
    }
  end
end
