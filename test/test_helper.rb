require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rspec/json_matcher'

OmniAuth.config.test_mode = true

class ActiveSupport::TestCase
  def including?(actual, expected)
    reason = {}
    RSpec::JsonMatcher::FuzzyComparer.compare(
      actual,
      expected,
      &reason
    )
  end

  def json_including?(body, expected)
    including?(JSON.parse(body), expected)
  end

  def status_code(status)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end

  def sign_in(user)
    OmniAuth.config.add_mock(:google_oauth2, {
      uid: user.uid,
      info: {
        email: user.email
      }
    })

    get '/auth/google_oauth2'
    follow_redirect!
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end
end
