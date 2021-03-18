Rails.application.routes.draw do
  resources :stats_batches
  resources :player_ids, only: :index
  resources :team_uploads, only: %i[new create]

  root 'fresh_stats#index'
end
