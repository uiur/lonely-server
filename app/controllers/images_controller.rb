class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.order(created_at: :desc).limit(10).to_a
    @objs = @images.map(&:s3_object)
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    space = Space.find_by!(name: params[:name])
    @image = space.images.create!(image_params)

    obj = @image.s3_object
    @presigned_url = obj.presigned_url(:put, content_type: 'image/jpeg')

    respond_to do |format|
      format.json { render json: { presigned_url: @presigned_url }, status: :created }
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.permit(:name).fetch(:image, {})
    end
end
