root to: 'home#index'

resources :proposals, only: %i[index show]
patch '/proposal_statuses/:id', to: 'proposal_statuses#update'
