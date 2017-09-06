json.comments @comments do |comment|
  json.id comment.id
  json.user_title comment.user.title
  json.user_avatar_path comment.user.avatar.path
  json.content comment.content
  json.created_at comment.created_at.strftime("%d/%m/%Y")
end
