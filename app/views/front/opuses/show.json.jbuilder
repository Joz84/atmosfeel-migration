json.(@opus, :id, :atmosphere_id, :play_time_id, :title, :abstract, :font_color, :font_family, :language_id, :published, :author_override)
json.price number_to_currency(@opus.price, format: "%n")
json.atmosphere_label @opus.atmosphere.label
json.play_time_label @opus.play_time.label
json.language_label @opus.language.label
json.cover do
  json.url @opus.cover_url
end
json.musics_attributes @opus.musics
json.voices_attributes @opus.voices
json.keyword_opuses_attributes @opus.keyword_opuses do |keyword_opus|
  # stupid fix 
  next if keyword_opus.keyword_id.nil?
  json.id keyword_opus.id
  json.keyword_id keyword_opus.keyword.id
  json.label keyword_opus.keyword.label
end
json.collaborations_attributes @opus.collaborations do |collaboration|
  json.(collaboration, :id, :user_id, :collaboration_type_id)
  json.label collaboration.collaboration_type.label
  json.user_attributes collaboration.user
end
json.chapters_attributes @opus.chapters do |chapter| 
  json.(chapter, :id, :title, :content, :font_color, :position)
  json.background_image do
    json.url chapter.background_image_url
  end
  json.slider_entries_attributes chapter.slider_entries
  json.musics_attributes chapter.musics
  json.voices_attributes chapter.voices
end