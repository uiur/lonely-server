require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @owner = FactoryBot.create(:user)
    @space.permissions.create!(user: @owner)

    @other = FactoryBot.create(:user)
  end

  # GET /:name
  test 'user requests showing a space' do
    sign_in(@owner)

    get "/#{@space.name}"
    assert { @response.status == status_code(:ok) }
  end

  test 'other requests showing a space' do
    sign_in(@other)

    get "/#{@space.name}"
    assert { @response.status == status_code(:forbidden) }
  end

  test 'other requests showing a public space' do
    sign_in(@other)
    @space.update!(visibility: :public)

    get "/#{@space.name}"
    assert { @response.status == status_code(:ok) }
  end

  test 'guest requests showing a public space' do
    @space.update!(visibility: :public)

    get "/#{@space.name}"
    assert { @response.status == status_code(:ok) }
  end

  # GET /spaces
  test 'requests spaces' do
    sign_in(@owner)
    get '/spaces'

    assert { @response.status = status_code(:ok) }
  end
end
