# frozen_string_literal: true

class MyLikesCarrier
  def initialize(posts_scope, page: nil, viewer:)
    @page = page || 1
    @posts_scope = posts_scope.page(page)
    @viewer = viewer
  end

  def page_scope
    @posts_scope
  end

  def cache_key
    {
      resource: 'my_likes',
      page: @page,
      count: @posts_scope.count,
      last_modified: @posts_scope.maximum(:updated_at)
    }
  end

  def to_hash
    {
      liked_posts: @viewer.likes.where(post: @posts_scope.pluck(:id)).pluck(:post_id)
    }
  end
end
