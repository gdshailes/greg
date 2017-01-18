Rails.application.routes.draw do

    root 'greghome#index'

    get 'greghome', to: 'greghome#greghome'
    get 'boriscam', to: 'boriscam#index'
    post 'boriscam/upload', to: 'boriscam#upload'

    resources :ride_log_bike
end
