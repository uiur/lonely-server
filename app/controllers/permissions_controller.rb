class PermissionsController < ApplicationController
  before_action :require_user
  
  def create
    @space = Space.find_by!(name: params[:name])

    unless @space.editable_by?(current_user)
      render status: :forbidden
      return 
    end

    @user = User.find_by!(email: params[:email])
    if @space.editable_by?(@user)
      render status: :bad_request
      return
    end

    Permission.create!(user: @user, space: @space)

    render status: :created
  end
end
