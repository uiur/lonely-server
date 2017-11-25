require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = FactoryBot.create(:space)
    @owner = FactoryBot.create(:user)
    @space.permissions.create!(user: @owner)
  end

  # GET /:name/images/latest
  test 'GET /:name/images/latest' do
    image = @space.images.create!(timestamp: Time.now)

    sign_in(@owner)
    get "/#{@space.name}/images/latest"
    assert { @response.status == status_code(:found) }
    assert { @response.location =~ /#{image.timestamp.to_date.to_s}/ }
  end

  test 'requests json' do
    image = @space.images.create!(timestamp: Time.now)

    sign_in(@owner)
    get "/#{@space.name}/images/latest", as: :json

    assert { @response.status == status_code(:ok) }
    assert {
      json_including?(@response.body, {
        created_at: String,
        presigned_url: String,
      })
    }
  end

  test 'guest requests latest' do
    get "/#{@space.name}/images/latest", as: :json
    assert { @response.status == status_code(:forbidden) }
  end

  test 'normal user requests latest' do
    @user = FactoryBot.create(:user)
    sign_in(@user)
    get "/#{@space.name}/images/latest", as: :json
    assert { @response.status == status_code(:forbidden) }
  end

  test 'it returns 404 when there is no image' do
    sign_in(@owner)
    get "/#{@space.name}/images/latest"
    assert { @response.status == status_code(:not_found) }
  end

  # GET /:name/images
  test 'requests image list' do
    sign_in(@owner)

    get "/#{@space.name}/images"
    assert { @response.status == status_code(:ok) }
  end
end
