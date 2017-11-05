require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test ".key" do
    timestamp = Time.parse('2017-11-11 10:10:00')
    assert { Image.key(timestamp) == '2017-11-11/2017-11-11 10:10:00.jpg' }
  end

  test "#key" do
    space = Space.create(name: 'home')

    Timecop.freeze(Time.local(2017, 11, 11, 10, 10))
    image = Image.create(space: space)

    assert { image.key == '2017-11-11/2017-11-11 10:10:00.jpg' }
  end
end
