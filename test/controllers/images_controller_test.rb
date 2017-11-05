require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
  end

  test 'POST /:name/images' do
    timestamp = Time.at(Time.now.to_i)

    post "/#{@space.name}/images", params: { timestamp: timestamp.to_i }

    assert { @response.status == status_code(:created) }

    image = Image.find_by!(timestamp: timestamp)
    assert { image.space == @space }
  end
end
