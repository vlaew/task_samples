# frozen_string_literal: true

class PostsCursorCarrier
  PER_PAGE = 500

  attr_reader :page_scope

  delegate :cache_key, :cache_version,
           to: :page_scope

  def initialize(posts_scope, cursor: nil)
    @initial_scope = posts_scope
    @page_scope = position_cursor(posts_scope, cursor).limit(PER_PAGE)
  end

  def to_hash
    {
      data: posts.map(&:to_hash),
      meta: {
        total_count: @initial_scope.count,
        cursor_next: posts.last&.id
      }
    }
  end

  def posts
    PostCarrier.wrap(@page_scope)
  end

  private

  def position_cursor(scope, cursor)
    return scope unless cursor

    scope.where('id < ?', cursor.to_i)
  end
end
