class SpaceSettingsController < ApplicationController
  before_action :set_space
  before_action :require_user
  before_action :require_editable

  def show
  end

  def update
    setting = @space.space_setting || @space.create_space_setting!

    setting.update!(setting_params)
  end

  private
  def setting_params
    params.require(:space_setting).permit(:slack_incoming_webhook_url)
  end
end
