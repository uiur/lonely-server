Rails.application.routes.draw do
  resources :spaces, only: [:index, :new, :create]

  scope ':name' do
    resources :uploads, only: [:create], constraints: { format: :json }
    resources :images, only: [:create, :index] do
      collection do
        get :latest, to: 'images#latest', as: :latest
      end
    end

    get :settings, to: 'spaces#settings', as: :settings
    post :permissions, to: 'permissions#create'
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get ':name', to: 'spaces#show', as: :space
end
