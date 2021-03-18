# frozen_string_literal: true

module Api
  module V1
    class MyLikesController < BaseController
      before_action :authenticate_user!

      def index
        likes_carrier = MyLikesCarrier.new(
          Post.ordered_chronologically,
          page: params[:page],
          viewer: @current_user
        )

        if stale?(likes_carrier.page_scope) # rubocop:disable Style/GuardClause:
          render json: Rails.cache.fetch(likes_carrier.cache_key) { likes_carrier.to_hash }
        end
      end
    end
  end
end
