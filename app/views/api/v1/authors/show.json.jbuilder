json.id @author.id
json.title @author.title
json.avatar_path @author.avatar.path
json.resume @author.resume
json.opuses @author.opuses do |opus|
  json.opus_id opus.id
  json.title opus.title
end
