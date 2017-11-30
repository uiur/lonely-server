class Api::SlackController < Api::ApplicationController
  skip_before_action :authenticate
  before_action :verify_slack_token

  def slash
    raise Error::Forbidden unless params[:token] == 'token'
  end

  private

  def verify_slack_token
    space = Space.find_by!(slack_slash_token: token)
    latest_image = space.images.order(timestamp: :desc).first

    render json: {
      text: '',
      attachments: [
        { image_url: latest_image.url }
      ]
    }
  end
end
