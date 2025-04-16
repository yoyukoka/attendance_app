Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    authenticated :user do
      root 'events#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    get 'users/show', to: 'users#show', as: :show_user
  end

  resources :users, only: %i[index destroy]
  resources :users do
    member do
      patch :admin_toggle
    end
  end

  resources :events do
    member do
      patch :archive
    end
    collection do
      get :archived
    end
    resources :attendances, only: [:create]
  end

  post '/webhook', to: 'webhooks#callback'
end
