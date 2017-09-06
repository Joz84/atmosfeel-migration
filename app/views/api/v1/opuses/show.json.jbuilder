json.id @opus.id
json.title @opus.title
json.abstract @opus.abstract.gsub("\n", "<br>")
json.cover_url front_root_url + @opus.cover_url
json.cover_url_source @opus.chapters.first.slider_entries.first.try(:file) ? front_root_url + @opus.chapters.first.slider_entries.first.file.url : nil
json.atmosphere_label @opus.atmosphere.label
json.likes_count @opus.likes_count
json.play_time_label @opus.play_time.label
json.opus_url front_experience_product_fr_url(@opus)
json.opus_language @opus.language.label
json.voice_language @opus.voices.first.try(:title)
# json.voice_language @opus.voices.any? ? @opus.voices.first.title : nil
json.owner @opus.user.title
json.artists @opus.collaborations do |collaboration|
  json.title collaboration.user.title
  json.collaboration_type collaboration.collaboration_type.label
end
json.author_alternate @opus.author_override
json.readed @opus.readed_by_user?(@user)
json.keywords @opus.keywords do |keyword|
  json.label keyword.label
end

json.first_chapter do
  json.id @opus.chapters.first.id
  json.title @opus.chapters.first.title
  json.content @opus.chapters.first.content
  json.font_color @opus.chapters.first.font_color
  json.position @opus.chapters.first.position
  json.background_image do
    json.url !@opus.chapters.first.background_image.blank? ? front_root_url + @opus.chapters.first.background_image.url : nil
  end
  json.sliders_entries_attributes do
    json.array! @opus.chapters.first.slider_entries do |slider_entry|
      json.id slider_entry.id
      json.file slider_entry.file ? front_root_url + slider_entry.file.url : nil
      json.position slider_entry.position
    end
  end
  json.musics_attributes do
    json.array! @opus.chapters.first.musics do |music|
      json.id music.id
      json.file music.file ? front_root_url + music.file.url : nil
      json.type music.try(:type)
      json.title music.try(:title)
    end
  end
  json.voices_attributes do
    json.array! @opus.chapters.first.voices do |voice|
      json.id voice.id
      json.file voice.file ? front_root_url + voice.file.url : nil
      json.type voice.try(:type)
      json.title voice.try(:title)
      json.soundable_id voice.soundable_id
      json.soundable_type voice.soundable_type
    end
  end
end

json.chapters_count @opus.chapters.count
json.musics_count @opus.musics.count
json.voices_count @opus.voices.count
json.sliders_count @opus.slider_entries.count
