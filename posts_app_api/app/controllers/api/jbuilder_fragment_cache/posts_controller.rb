# frozen_string_literal: true

module Api
  module JbuilderFragmentCache
    class PostsController < BasePostsController
      include ActionController::Caching

      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )
      end
    end
  end
end
