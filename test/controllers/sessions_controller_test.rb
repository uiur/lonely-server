require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @owner = FactoryBot.create(:user)
    @space.permissions.create!(user: @owner)
  end

  test 'request signin from login link' do
    sign_in(@owner)

    assert { @response.status == status_code(:found) }
    assert { @response.location == spaces_url }
  end

  test 'owner requests showing a space without login' do
    OmniAuth.config.add_mock(:google_oauth2, {
      uid: @owner.uid,
      info: {
        email: @owner.email
      }
    })

    get "/#{@space.name}"
    assert { @response.status == status_code(:found) }
    assert { @response.location == @request.base_url + '/auth/google_oauth2' }

    follow_redirect! #=> google
    follow_redirect! #=> /auth/google_oauth2/callback

    assert { @response.status == status_code(:found) }
    assert { @response.location == space_show_url(@space.name)}
  end
end
