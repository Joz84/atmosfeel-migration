json.opuses @opuses do |opus|
  json.id opus.id
  json.title opus.title
  json.cover_url front_root_url + opus.cover_url
  json.cover_url_source opus.chapters.first.try(:slider_entries).try(:first).try(:file) ? front_root_url + opus.chapters.first.slider_entries.first.file.url : nil
  json.atmosphere_label opus.atmosphere.label
  json.likes_count opus.likes.count
  json.play_time_label opus.play_time.label
  json.readed opus.readed_by_user?(@user)
end
