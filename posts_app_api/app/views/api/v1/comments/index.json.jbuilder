json.data @comments_carrier.comments do |comment|
  json.id comment.id
  json.type 'comment'
  json.attributes do
    json.extract! comment, :body, :created_at
    json.created_by do
      json.id comment.user_id
      json.name comment.user.name
    end
  end
end

json.meta do
  json.total_count @comments_carrier.total_count
end
