Rails.application.routes.draw do

  devise_for :users

  root to: "greghome#index"
  get 'greghome', to: 'greghome#greghome'
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

  resources :diary_entry

  get 'test', to: 'test#index'

end