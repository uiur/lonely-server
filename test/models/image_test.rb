require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test ".key" do
    timestamp = Time.parse('2017-11-11 10:10:00')
    assert { Image.key(timestamp) == '2017-11-11/2017-11-11 10:10:00.jpg' }
  end

  test "#key" do
    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 10, 10))
    assert { image.key == '2017-11-11/2017-11-11 10:10:00.jpg' }
  end

  test '.build_s3_object' do
    timestamp = Time.now
    obj = Image.build_s3_object(timestamp)

    assert { obj.key == Image.key(timestamp) }
  end
end
