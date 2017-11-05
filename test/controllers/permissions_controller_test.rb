require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @owner = FactoryBot.create(:user)
    @space.permissions.create!(user: @owner)
  end

  # POST /:name/permissions
  test 'create a permission for a user' do
    sign_in(@owner)
    @target_user = FactoryBot.create(:user)
    assert { !@space.viewable_by?(@target_user) }

    post "/#{@space.name}/permissions", params: { email: @target_user.email }, as: :json
    assert { @response.status == status_code(:created) }

    assert { @space.viewable_by?(@target_user)}
  end
end
