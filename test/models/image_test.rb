require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    @space = FactoryBot.create(:space)
  end

  test '#key' do
    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 10, 10), space: @space)
    assert { image.key == "#{@space.name}/2017-11-11/2017-11-11 10:10:00.jpg" }

    ENV['LONELY_BUCKET_NAMESPACE'] = 'foo/bar/'

    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 10, 10), space: @space)
    assert { image.key == "foo/bar/#{@space.name}/2017-11-11/2017-11-11 10:10:00.jpg" }

    ENV['LONELY_BUCKET_NAMESPACE'] = ''
  end

  test '#should_be_recognized?' do
    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 12, 0), space: @space)
    assert { image.should_be_recognized? }

    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 12, 1), space: @space)
    assert { image.should_be_recognized? == false }

    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 1, 0), space: @space)
    assert { image.should_be_recognized? == false }

    ENV['LONELY_DISABLE_WORKER'] = '1'
    image = FactoryBot.create(:image, timestamp: Time.local(2017, 11, 11, 12, 0), space: @space)
    assert { image.should_be_recognized? == false }
    ENV['LONELY_DISABLE_WORKER'] = nil
  end
end
