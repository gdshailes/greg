Rails.application.routes.draw do

  devise_for :users

  root to: "greghome#index"
  get 'greghome', to: 'greghome#greghome'
  get 'boriscam', to: 'boriscam#index'
  post 'boriscam/upload', to: 'boriscam#upload'

  get 'ride_log', to: 'ride_log#index'

  resources :ride_log_bike
  resources :ride_log_ride

  resources :diary_entry

end
