require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)

    @user = FactoryBot.create(:user)
    @user.permissions.create(space: @space)
  end

  # GET /
  test 'returns ok for guest' do
    get '/'
    assert { response.status == status_code(:ok) }
  end

  test 'redirect to a space for login user' do
    sign_in(@user)

    get '/'

    assert { response.status == status_code(:found) }
    assert { response.location == space_show_url(@space.name) }
  end

  test 'redirect to spaces if user has multiple permissions' do
    @user.permissions.create!(space: FactoryBot.create(:space))
    sign_in(@user)

    get '/'

    assert { response.status == status_code(:found) }
    assert { response.location == spaces_url }
  end
end
