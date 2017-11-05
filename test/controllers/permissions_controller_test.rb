require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get permissions_create_url
    assert_response :success
  end

end
