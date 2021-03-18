# frozen_string_literal: true

module Api
  module FastJsonapiSerializerCached
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )
        response_json = Rails.cache.fetch(@posts_carrier.cache_key, version: @posts_carrier.cache_version) do
          @posts_carrier.serialized_json
        end

        render json: response_json
      end
    end
  end
end
