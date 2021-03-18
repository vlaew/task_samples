# frozen_string_literal: true

module Api
  module FastJsonapiSerializer
    class PostsController < BasePostsController
      def index
        @posts_carrier = PostsCarrier.new(
          Post.ordered_chronologically,
          page: params[:page]
        )

        render json: @posts_carrier.serialized_json
      end
    end
  end
end
