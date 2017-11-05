require 'test_helper'

class UploadsControllerTest < ActionDispatch::IntegrationTest
  test 'POST /:name/uploads' do
    space = FactoryBot.create(:space)

    timestamp = Time.now
    Timecop.freeze(timestamp)

    post "/#{space.name}/uploads"

    expected = {
      timestamp: timestamp.to_i,
      presigned_url: String
    }

    assert {
      json_including?(@response.body, expected)
    }
  end
end
