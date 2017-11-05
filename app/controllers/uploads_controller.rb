class UploadsController < ApplicationController
  def create
    space = Space.find_by!(name: params[:name])

    timestamp = Time.now
    obj = Image.build_s3_object(timestamp)
    @presigned_url = obj.presigned_url(:put, content_type: 'image/jpeg')

    render json: {
      timestamp: timestamp.to_i,
      presigned_url: @presigned_url
    }
  end
end
