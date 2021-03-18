# frozen_string_literal: true

class PostCarrier < SimpleDelegator
  def self.wrap(posts)
    posts.map { |post| new(post) }
  end

  def to_hash
    {
      id: id.to_s,
      type: 'post',
      attributes: {
        body: body,
        likes_count: likes_count,
        published_at: created_at
      },
      relationships: {}
    }
  end

  def likes_count
    super.to_i
  end
end
