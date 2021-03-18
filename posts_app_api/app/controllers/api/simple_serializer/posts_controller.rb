# frozen_string_literal: true

module Api
  module SimpleSerializer
    class PostsController < BasePostsController
      include ActionController::Caching

      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )

        render json: @posts_carrier.to_hash
      end
    end
  end
end
