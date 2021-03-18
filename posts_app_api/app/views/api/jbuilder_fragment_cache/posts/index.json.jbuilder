json.data @posts_carrier.posts do |post|
  json.cache! post do
    json.id post.id.to_s
    json.type 'post'
    json.attributes do
      json.extract! post, :body, :likes_count
      json.published_at post.created_at
    end
    json.relationships({})
  end
end

json.meta do
  json.total_count @posts_carrier.total_count
end
