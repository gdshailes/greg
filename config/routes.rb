Rails.application.routes.draw do

    root 'greghome#index'

    get 'greghome', to: 'greghome#greghome'
    get 'boriscam', to: 'boriscam#index'
    post 'boriscam/upload', to: 'boriscam#upload'

    get 'ride_log', to: 'ride_log#index'

    get 'api/new_ride', to: 'api/new_ride#index'
    post 'api/new_ride', to: 'api/new_ride#new_ride'

    resources :ride_log_bike
    resources :ride_log_ride

    get '/api/ping', to: 'api/ping#index'
    get '/api/ride_log_ride', to: 'api/ride_log_ride#index'
    get '/api/ride_log_ride/create', to: 'api/ride_log_ride#create'

    get '/subscriptions', to: 'webhook_subscription#index'

    get '/api/hook', to: 'webhook_subscription#index'
    post '/api/hook', to: 'api/hook#subscribe'
    delete '/api/hook', to: 'api/hook#unsubscribe'

end
