class ApplicationController < ActionController::Base
  module Error
    class Forbidden < StandardError; end
    class Unauthorized < StandardError; end
  end

  rescue_from Error::Forbidden do
    render status: :forbidden, plain: 'forbidden'
  end

  rescue_from Error::Unauthorized do
    respond_to do |format|
      format.html { redirect_to spaces_path }
      format.json { render status: :unauthorized, plain: 'unauthorized' }
    end
  end

  helper_method :current_user

  def current_user
    return unless session['user_id']

    @user ||= User.find(session['user_id'])
  end

  def require_user
    unless current_user
      raise Error::Unauthorized
    end
  end
end
