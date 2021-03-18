# frozen_string_literal: true

module Api
  module V1
    class CommentsController < BaseController
      def index
        post = Post.find(params[:post_id])

        @comments_carrier = CommentsCarrier.fetch_comments(
          post.comments.ordered_chronologically.includes(:user),
          pagination: { page: params[:page], per_page: params[:per_page] }
        )
      end
    end
  end
end
