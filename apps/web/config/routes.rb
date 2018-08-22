root to: 'home#index'

resources :proposals, only: %i[index new create show]
patch '/proposal_statuses/:id', to: 'proposal_statuses#update'

resources :variants, only: %i[create]
resources :traits, only: %i[create]
resources :proposal_statuses, only: %i[update]
