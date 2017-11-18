class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :update, :settings]
  before_action :require_user, only: [:create, :settings, :index]
  before_action :require_viewable, only: [:show]
  before_action :require_editable, only: [:update, :settings]

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
        format.html { redirect_to space_show_path(@space.name), notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @space.update(update_params)
        format.html { redirect_to setting_path(@space.name) }
      else
        format.html { redirect_to setting_path(@space.name) }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name)
    end

    def update_params
      params.require(:space).permit(:visibility)
    end
end
