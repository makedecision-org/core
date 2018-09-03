root to: 'home#index'

get '/dashboard', to: 'organisations#index', as: :dashboard

resources :proposals, only: %i[index new create show]

# proposal routes
resources :comments, only: %i[create]
resources :variants, only: %i[create destroy]
resources :traits, only: %i[create]
resources :proposal_statuses, only: %i[update]
delete '/traits', to: 'traits#destroy', as: :trait

resources :organisations, only: %i[show] do
  resources :proposals, only: %i[new create show], controller: 'proposals'
end
