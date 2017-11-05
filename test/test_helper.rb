require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rspec/json_matcher'

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
end
