Rails.application.routes.draw do

  resources :test_children
  resources :test_parents
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
    resources :accounts
  end

  resources :diary_entry

end
