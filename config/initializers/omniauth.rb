Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_APP_ID'] || ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_APP_SECRET'] || ENV['GOOGLE_CLIENT_SECRET']
end
