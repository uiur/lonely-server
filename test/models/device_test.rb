require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test '.create_with_token' do
    space = FactoryBot.create(:space)
    device = Device.create_with_token(space: space)

    assert { device.valid? }
  end
end
