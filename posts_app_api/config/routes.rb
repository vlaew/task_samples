Rails.application.routes.draw do
  concern :likeable do
    post :toggle_like, on: :member
  end

  namespace :api, defaults: { format: :json }, constraints: { format: 'json' } do
    namespace :v1 do
      resources :posts, only: :index, concerns: [:likeable] do
        resources :comments, only: :index
      end

      resources :my_likes, only: :index
      resources :sessions, only: :create
    end

    namespace :jbuilder do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :jbuilder_fragment_cache do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :simple_serializer do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :simple_serializer_cached do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :fast_jsonapi_serializer do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :fast_jsonapi_serializer_cached do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :fast_jsonapi_serializer_cached_http_cache do
      resources :posts, only: :index, concerns: [:likeable]
    end

    namespace :cursor do
      resources :posts, only: :index, concerns: [:likeable]
    end
  end

  root to: 'api/v1/posts#index', defaults: { format: :json }
end
