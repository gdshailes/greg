Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "greghome#root"

  get 'users/index', to: 'users#index'
  get 'greghome', to: 'greghome#greghome'
  get 'greghome/denied', to: 'greghome#denied'
  get 'greghome/s382', to: 'greghome#s382'
  get 'boriscam', to: 'boriscam#index'
  post 'boriscam/upload', to: 'boriscam#upload'

  get 'ride_log', to: 'ride_log#index'
  namespace :ride_log do
    resources :bike
    resources :ride
  end

  namespace :finances do
    resources :accounts do
      resources :transactions
      resources :bills do
        patch 'record_payment', to: 'bills#record_payment'
      end
      resource :transfer, only: [:new, :create]
    end
  end

  get 'ratrace', to: 'ratrace#index'
  namespace :ratrace do
    resources :posts do
      get 'post_to_facebook', to: 'posts#post_to_facebook'
      resources :comments do

      end
    end
  end

  resources :diary_entry

end