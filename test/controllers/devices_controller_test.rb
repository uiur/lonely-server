require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @user = FactoryBot.create(:user)
    @space.permissions.create!(user: @user)
  end

  test 'create devices' do
    sign_in(@user)

    post "/#{@space.name}/devices"
    assert { @response.location == setting_url(@space.name) }

    assert { @space.devices.count == 1 }
  end
end
