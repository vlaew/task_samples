# frozen_string_literal: true

module Api
  class BasePostsController < BaseController
    before_action :authenticate_user!, only: [:toggle_like]

    def toggle_like
      post = Post.find(params[:id])

      TogglePostLikeService.new(post, @current_user).perform
    end
  end
end
