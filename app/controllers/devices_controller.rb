class DevicesController < ApplicationController
  before_action :set_space
  before_action :require_editable

  def create
    device = @space.devices.create_with_token

    respond_to do |format|
      if device.valid?
        format.html { redirect_to setting_path(@space.name) }
      else
        format.html { redirect_to setting_path(@space.name) }
      end
    end
  end
end
