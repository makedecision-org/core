root to: 'home#index'

resources :proposals, only: %i[index new create show]

resources :comments, only: %i[create]
resources :variants, only: %i[create]
resources :traits, only: %i[create]
resources :proposal_statuses, only: %i[update]
