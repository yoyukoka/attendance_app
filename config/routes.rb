Rails.application.routes.draw do
  root 'events#index'

  resources :events do
    resources :attendances, only: [:create]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
