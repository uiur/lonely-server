require 'test_helper'

class Api::SlackControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @first_image = @space.images.create!(timestamp: 10.minutes.ago)
    @second_image = @space.images.create!(timestamp: Time.now)

    @token = Token.create!(
      token_type: :slack_slash,
      secret: Token.generate_secret,
      space: @space
    )
  end

  test 'trigger slash command with valid secret' do
    post '/api/slack/slash', params: { secret: @token.secret }, as: :json

    assert { @response.status == status_code(:ok) }

    actual = @response.body
    expected = {
      attachments: [
        {
          image_url: String
        }
      ]
    }

    assert {
      json_including?(actual, expected)
    }
  end

  test 'trigger slash command with wrong secret' do
    post '/api/slack/slash', params: { secret: 'wrong' }, as: :json
    assert { @response.status == status_code(:forbidden) }
  end
end
