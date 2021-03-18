# frozen_string_literal: true

module Api
  module FastJsonapiSerializerCachedHttpCache
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )

        if stale?(@posts_carrier.posts_scope, public: true) # rubocop:disable Style/GuardClause:
          response_json = Rails.cache.fetch(@posts_carrier.cache_key, version: @posts_carrier.cache_version) do
            @posts_carrier.serialized_json
          end

          render json: response_json
        end
      end
    end
  end
end
