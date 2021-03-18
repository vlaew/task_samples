# frozen_string_literal: true

class TogglePostLikeService
  def initialize(post, user)
    @post = post
    @user = user
  end

  def perform
    Post.transaction do
      like = @post.likes.find_or_initialize_by(user: @user)

      if like.persisted?
        like.destroy!
      else
        like.save!
      end
    end
  end
end
