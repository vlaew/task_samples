# frozen_string_literal: true

class CommentsCarrier
  def self.fetch_comments(comments_scope, pagination:)
    comments_page = comments_scope.page(pagination[:page] || 1).per(pagination[:per_page])
    new(comments_page)
  end

  def initialize(comments_scope)
    @comments_scope = comments_scope
  end

  def comments
    @comments_scope
  end

  def total_count
    @comments_scope.total_count
  end
end
