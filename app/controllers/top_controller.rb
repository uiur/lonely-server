class TopController < ApplicationController
  before_action :redirect_if_logined

  def index
  end

  private
  def redirect_if_logined
    if current_user
      permissions = current_user.permissions.includes(:space)
      if permissions.size == 1
        redirect_to space_show_path(permissions.first.space.name)
      else
        redirect_to spaces_path
      end
    end
  end
end
