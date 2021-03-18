# frozen_string_literal: true

module Api
  module V1
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )

        # Since posts feed page is the same for all users we can set 'public' parameter to true
        # which will add header 'Cache-Control: public' to response headers
        expires_in 30.minutes, public: true
        etag = "#{@posts_carrier.cache_key}-#{@posts_carrier.cache_version}"
        if stale?(etag) # rubocop:disable Style/GuardClause:
          # Fetching posts page response from cache generating it on cache miss
          response_json = Rails.cache.fetch(@posts_carrier.cache_key, version: @posts_carrier.cache_version) do
            @posts_carrier.to_hash
          end
          render json: response_json
        end
      end
    end
  end
end
