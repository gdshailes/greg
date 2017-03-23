Rails.application.routes.draw do

    root 'greghome#index'

    get 'greghome', to: 'greghome#greghome'
    get 'boriscam', to: 'boriscam#index'
    post 'boriscam/upload', to: 'boriscam#upload'

    get 'ride_log', to: 'ride_log#index'

    resources :ride_log_bike
    resources :ride_log_ride

    get '/api/ping', to: 'api/ping#index'
    get '/api/ride_log_ride', to: 'api/ride_log_ride#index'
end
