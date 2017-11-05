require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    @space = FactoryBot.create(:space)
  end

  test "#key" do
    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 10, 10), space: @space)
    assert { image.key == "#{@space.name}/2017-11-11/2017-11-11 10:10:00.jpg" }
  end
end
