root to: 'home#index'

resources :proposals, only: %i[index show]
