# frozen_string_literal: true

module Api
  module SimpleSerializerCached
    class PostsController < BasePostsController
      include ActionController::Caching

      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )

        response_json = Rails.cache.fetch(@posts_carrier.cache_key, version: @posts_carrier.cache_version) do
          @posts_carrier.to_hash
        end
        render json: response_json
      end
    end
  end
end
