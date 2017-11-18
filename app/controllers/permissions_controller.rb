class PermissionsController < ApplicationController
  before_action :require_user
  before_action :require_editable

  def create
    @user = User.find_by!(email: params[:email])
    if @space.editable_by?(@user)
      render status: :bad_request, plain: 'user already has a permission'
      return
    end

    Permission.create!(user: @user, space: @space)

    respond_to do |format|
      format.html { redirect_to settings_path(@space.name) }
      format.json { render status: :created, plain: 'created' }
    end
  end

  private

  def require_editable
    @space = Space.find_by!(name: params[:name])

    unless @space.editable_by?(current_user)
      raise Errors::Forbidden
    end
  end
end
