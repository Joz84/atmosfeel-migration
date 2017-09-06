json.authors @authors do |author|
  json.id author.id
  json.title author.title
  json.avatar_path author.avatar.path
  json.type @opus.collaborations.where(user: author).first.collaboration_type.label
end
