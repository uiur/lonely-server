Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :images, only: [:index]
  resources :spaces, only: [:index, :new, :create]

  scope ':name' do
    resources :images, only: [:create]
  end

  get ':name', to: 'spaces#show', as: :space
end
