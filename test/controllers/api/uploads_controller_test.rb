require 'test_helper'

class Api::UploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @device = Device.create_with_token(space: @space)
  end

  # POST /api/uploads
  test 'request without token' do
    post '/api/uploads', as: :json
    assert { @response.status == status_code(:unauthorized) }
  end

  test 'request with wrong token' do
    post '/api/uploads', headers: { Authorization: 'Bearer wtf' }, as: :json
    assert { @response.status == status_code(:unauthorized) }
  end

  test 'request with valid token' do
    timestamp = Time.now
    Timecop.freeze(timestamp)

    post '/api/uploads', headers: { Authorization: "Bearer #{@device.token}" }, as: :json

    assert { @response.status == status_code(:ok) }

    expected = {
      timestamp: timestamp.to_i,
      presigned_url: String
    }

    assert {
      json_including?(@response.body, expected)
    }
  end
end
