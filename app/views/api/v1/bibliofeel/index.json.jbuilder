json.bibliofeel @bibliofeel do |opus|
  json.id opus.id
  json.title opus.title
  json.cover_url front_root_url + opus.cover_url
  json.atmosphere_label opus.atmosphere.label
  json.likes_count opus.likes.count
  json.play_time_label opus.play_time.label
  json.readed "not implemented yet"
end
