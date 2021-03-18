# frozen_string_literal: true

module Api
  module Jbuilder
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )
      end
    end
  end
end
