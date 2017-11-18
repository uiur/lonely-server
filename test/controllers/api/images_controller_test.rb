require 'test_helper'

class Api::ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @device = Device.create_with_token(space: @space)
  end

  test 'POST /api/images' do
    timestamp = Time.at(Time.now.to_i)

    post "/api/images", headers: { Authorization: "Bearer #{@device.token}" }, params: { timestamp: timestamp.to_i }, as: :json

    assert { @response.status == status_code(:created) }

    image = Image.find_by!(timestamp: timestamp)
    assert { image.space == @space }
  end
end
