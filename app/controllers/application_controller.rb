class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  module Error
    class NotFound < StandardError; end
    class Forbidden < StandardError; end
    class Unauthorized < StandardError; end
  end

  rescue_from ActiveRecord::RecordNotFound, Error::NotFound do
    respond_to do |format|
      format.html { render status: :not_found, plain: 'not found' }
      format.json { render status: :not_found, plain: 'not found' }
    end
  end

  rescue_from Error::Forbidden do
    respond_to do |format|
      format.html do
        if current_user
          render status: :forbidden, plain: 'forbidden'
        else
          redirect_to_login
        end
      end

      format.json { render status: :forbidden, plain: 'forbidden' }
    end
  end

  rescue_from Error::Unauthorized do
    respond_to do |format|
      format.html { redirect_to_login }
      format.json { render status: :unauthorized, plain: 'unauthorized' }
    end
  end

  helper_method :current_user

  def current_user
    return unless session['user_id']

    @user ||= User.find(session['user_id'])
  end

  helper_method :google_oauth2_path

  def google_oauth2_path
    '/auth/google_oauth2'
  end

  protected

  def set_space
    @space = Space.find_by!(name: params[:name])
  end

  def require_user
    unless current_user
      raise Error::Unauthorized
    end
  end

  def require_viewable
    unless @space.viewable_by?(current_user)
      raise Error::Forbidden
    end
  end

  def require_editable
    unless @space.editable_by?(current_user)
      raise Error::Forbidden
    end
  end

  def redirect_to_login
    session[:login_from_path] = request.fullpath
    redirect_to google_oauth2_path
  end
end
