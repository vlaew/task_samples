# frozen_string_literal: true

class PostsCarrier
  attr_reader :posts_scope

  delegate :cache_key, :cache_version, :total_count,
           to: :posts_scope

  def initialize(posts_scope, page: nil)
    @page = page || 1
    @posts_scope = posts_scope.page(page)
  end

  def to_hash
    {
      data: posts.map(&:to_hash),
      meta: {
        total_count: @posts_scope.total_count
      }
    }
  end

  def serialized_json
    options = {
      meta: { total_count: @posts_scope.total_count }
    }
    PostSerializer.new(@posts_scope, options).serialized_json
  end

  def posts
    PostCarrier.wrap(@posts_scope)
  end
end
