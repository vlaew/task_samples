# frozen_string_literal: true

module Api
  module Cursor
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCursorCarrier.new(
          Post.ordered_chronologically,
          cursor: params[:cursor]
        )

        expires_in 30.minutes, public: true
        etag = "#{@posts_carrier.cache_key}-#{@posts_carrier.cache_version}"
        if stale?(etag) # rubocop:disable Style/GuardClause:
          response_json = Rails.cache.fetch(@posts_carrier.cache_key, version: @posts_carrier.cache_version) do
            @posts_carrier.to_hash
          end

          render json: response_json
        end
      end
    end
  end
end
