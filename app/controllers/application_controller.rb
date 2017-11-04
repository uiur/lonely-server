class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session['user_id']

    @user ||= User.find(session['user_id'])
  end

  def require_user
    unless current_user
      render status: :unauthorized
    end
  end
end
