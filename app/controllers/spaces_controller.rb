class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy, :settings]
  before_action :require_user, only: [:show, :create, :settings]
  before_action :require_permission, only: [:show, :settings]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @images = @space.images.order(created_at: :desc).limit(10).to_a
    @objs = @images.map(&:s3_object)
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        @space.permissions.create(user: current_user)

        format.html { redirect_to space_path(@space.name), notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url, notice: 'Space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def settings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find_by!(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name)
    end

    def require_permission
      unless @space.viewable_by?(current_user)
        render status: :forbidden, plain: 'forbidden'
      end
    end
end
