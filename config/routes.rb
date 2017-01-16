Rails.application.routes.draw do

    root 'greg#index'

    get 'greghome', to: 'greg#greghome'
    get 'boriscam', to: 'boriscam#index'
    post 'boriscam/upload', to: 'boriscam#upload'

end
