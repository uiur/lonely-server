require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = Space.create!(name: 'home')
    @user = User.create!(uid: 'foo', email: 'bar@gmail.com')
    @space.permissions.create!(user: @user)
  end

  test 'get latest' do
    get '/home/images/latest', env: { user_id: @user.id }
    assert_response :success
  end
end
