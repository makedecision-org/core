# frozen_string_literal: true

root to: 'home#index'
get '/about', to: 'home#about'

get '/dashboard', to: 'organisations#index', as: :dashboard

resources :organisations, only: %i[show] do
  resources :teams, only: %i[new create show], controller: 'teams'
  resources :proposals, only: %i[new create show], controller: 'proposals' do
    resources :polls, only: %i[new create], controller: 'polls'
  end
end

# proposal routes
resources :comments, only: %i[create]
resources :variants, only: %i[create destroy]
resources :traits, only: %i[create]
resources :proposal_statuses, only: %i[update]
delete '/traits', to: 'traits#destroy', as: :trait
