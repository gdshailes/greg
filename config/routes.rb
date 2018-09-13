Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "greghome#root"

  get 'users/index', to: 'users#index'
  get 'greghome', to: 'greghome#greghome'
  get 'greghome/index', to: 'greghome#index'
  get 'greghome/denied', to: 'greghome#denied'
  get 'greghome/s382', to: 'greghome#s382'
  get 'privacy', to: 'privacy#index'

  namespace :finances do
    resources :accounts do
      resources :transactions do
        collection do
          get 'export', format: [:csv]
        end
      end

      resources :bills do
        get 'record_payment', to: 'bills#record_payment'
      end
      resource :transfer, only: [:new, :create]
    end
  end

  get 'ratrace', to: 'ratrace#index'
  namespace :ratrace do
    get 'post_to_facebook', to: 'posts#post_to_facebook'
    resources :posts do
      get 'get_next', to: 'posts#get_next'
      resources :comments do
      end
    end
  end

  resource :decision, only: [:new]
  resource :verify_the_pie, only: [:new]
  get 'verify_the_pie/ingredients', to: 'verify_the_pies#ingredients'
  get 'boriscam', to: 'boriscam#show'
  post 'boriscam/upload', to: 'boriscam#upload'
  resources :diary_entry

end