class Api::SlackController < Api::ApplicationController
  skip_before_action :authenticate
  before_action :verify_token

  # POST /api/slack/slash?secret=:secret
  def slash
    space = @token.space
    latest_image = space.images.order(timestamp: :desc).first

    render json: {
      response_type: 'in_channel',
      text: '',
      attachments: [
        { image_url: latest_image.url }
      ]
    }
  end

  private

  def verify_token
    @token = Token.find_by(secret: params[:secret], token_type: :slack_slash)
    raise Error::Forbidden unless @token
  end
end
