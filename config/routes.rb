Rails.application.routes.draw do
  root to: 'top#index'

  resources :spaces, only: [:index, :new, :create, :update], param: :name

  scope ':name' do
    resources :uploads, only: [:create], constraints: { format: :json }
    resources :images, only: [:create, :index] do
      collection do
        get :latest, to: 'images#latest', as: :latest
      end
    end

    resource :setting, controller: :space_settings, only: [:show, :update]

    post :permissions, to: 'permissions#create'
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get ':name', to: 'spaces#show', as: :space_show

end
