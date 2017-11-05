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
    redirect_to spaces_path
  end
end
