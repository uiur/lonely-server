class Api::ApplicationController < ::ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  skip_before_action :verify_authenticity_token
  before_action :authenticate

  protected
  attr_reader :current_device

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_device = Device.find_by(token: token)
      @current_device.present?
    end
  end
end
