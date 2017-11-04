Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :images, only: [:index, :create]
end
