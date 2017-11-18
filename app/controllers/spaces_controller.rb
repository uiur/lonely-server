class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :settings]
  before_action :require_user, only: [:create, :settings]
  before_action :require_viewable, only: [:show, :index]
  before_action :require_editable, only: [:settings]

  def index
    @spaces = current_user.permissions.includes(:space).map(&:space)
  end

  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.create_with_user(space_params, user: current_user)

    respond_to do |format|
      if @space.valid?
        format.html { redirect_to space_path(@space.name), notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  def settings
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name)
    end
end
