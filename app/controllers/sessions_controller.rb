class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_or_initialize_by(
      uid: auth_hash['uid']
    )

    unless user.persisted?
      user.email = auth_hash['info']['email']
      user.save!
    end

    session['user_id'] = user.id

    if session[:login_from_path]
      path = session[:login_from_path]
      session[:login_from_path] = nil
      redirect_to path
    else
      redirect_to spaces_path
    end
  end
end
