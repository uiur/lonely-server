require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @owner = FactoryBot.create(:user)
    @space.permissions.create!(user: @owner)
  end

  # GET /:name
  test 'user requests showing a space' do
    sign_in(@owner)

    get "/#{@space.name}"
    assert { @response.status == status_code(:ok) }
  end

  test 'other requests showing a space' do
    @user = FactoryBot.create(:user)
    sign_in(@user)

    get "/#{@space.name}"
    assert { @response.status == status_code(:forbidden) }
  end
end
