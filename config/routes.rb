Rails.application.routes.draw do
  root to: 'top#index'

  resources :spaces, only: [:index, :new, :create, :update], param: :name

  namespace :api, constraints: { format: :json } do
    post :uploads, to: 'uploads#create'
    post :images, to: 'images#create'
  end

  scope ':name' do
    resources :images, only: [:index] do
      collection do
        get :latest, to: 'images#latest', as: :latest
      end
    end

    resource :setting, controller: :space_settings, only: [:show, :update]

    resources :devices, only: [:create]

    post :permissions, to: 'permissions#create'
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get ':name', to: 'spaces#show', as: :space_show

  get '/hello/revision', to: RevisionPlate::App.new
end
