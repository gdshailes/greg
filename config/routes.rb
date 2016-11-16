Rails.application.routes.draw do

    root 'greg#index'

    get 'boriscam', to: 'boriscam#index'

    post 'boriscam/upload', to: 'boriscam#upload'

end
