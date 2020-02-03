Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'greghome#root'

  get 'greghome', to: 'greghome#greghome'
  get 'greghome/index', to: 'greghome#index'
  get 'greghome/denied', to: 'greghome#denied'
  get 'greghome/s382', to: 'greghome#s382'
  get 'privacy', to: 'privacy#index'
  get 'finances', to: 'finances/accounts#index'
  get 'ratrace', to: 'ratrace#index'
  get 'verify_the_pie/ingredients', to: 'verify_the_pies#ingredients'
  get 'diary', to: 'diary/entries#index'
  get 'device', to: 'device#index'

  resources :users, only: [:index]
  resource :decision, only: [:new]
  resource :verify_the_pie, only: [:new]
  resources :boriscams, only: [:index, :new, :create]

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

  namespace :ratrace do
    get 'post_to_facebook', to: 'posts#post_to_facebook'
    resources :posts do
      get 'get_next', to: 'posts#get_next'
      resources :comments
    end
  end

  namespace :diary do
    resources :entries
  end

end