json.id @opus.id
json.atmosphere_id @opus.atmosphere.id
json.play_time_id @opus.play_time.id
json.title @opus.title
json.abstract @opus.abstract
json.font_family @opus.font_family
json.language_id @opus.language_id
json.published @opus.published
json.author_override @opus.author_override
json.price @opus.price
json.atmosphere_label @opus.atmosphere.label
json.play_time_label @opus.play_time.label
json.language_label @opus.language.label
json.cover do
  json.url front_root_url + @opus.cover.url
  json.source_url @opus.chapters.first.slider_entries.first.try(:file) ? front_root_url + @opus.chapters.first.slider_entries.first.file.url : nil
end
json.musics_attributes do
  json.array! @opus.musics do |music|
    json.file do
      json.url front_root_url + music.file.url
    end
  end
end
json.voices_attributes do
  json.array! @opus.voices do |voice|
    json.file do
      json.url front_root_url + voice.file.url
    end
  end
end
json.keyword_opuses_attributes do
  json.array! @opus.keyword_opuses do |keyword_opus|
    json.id keyword_opus.id
    json.keyword_id keyword_opus.try(:keyword).try(:id)
    json.label keyword_opus.try(:keyword).try(:label)
  end
end
json.collaborations_attributes do
  json.array! @opus.collaborations do |collaboration|
    json.id collaboration.id
    json.user_id collaboration.user.id
    json.collaboration_type_id collaboration.collaboration_type_id
    json.label collaboration.collaboration_type.label
    json.user_attributes do
      json.id collaboration.user.id
      json.email collaboration.user.email
      json.created_at collaboration.user.created_at
      json.updated_at collaboration.user.updated_at
      json.firstname collaboration.user.firstname
      json.lastname collaboration.user.lastname
      json.phone collaboration.user.phone
      json.address collaboration.user.address
      json.artist collaboration.user.artist
      json.nickname collaboration.user.nickname
      json.resume collaboration.user.resume
      json.avatar do
        json.url front_root_url + collaboration.user.avatar.url
        json.settings_profile do
          json.url front_root_url + collaboration.user.avatar.settings_profile.url
        end
        json.mini do
          json.url front_root_url + collaboration.user.avatar.mini.url
        end
      end
      json.opuses_count collaboration.user.opuses_count
      json.title collaboration.user.title
      json.first_published_opus collaboration.user.first_published_opus
      json.accepts_contact collaboration.user.accepts_contact
      json.accepts_newsletter collaboration.user.accepts_newsletter
    end
  end
end
json.chapters_attributes do
  json.array! @opus.chapters do |chapter|
    json.id chapter.id
    json.title chapter.title
    json.content chapter.content
    json.font_color chapter.font_color
    json.position chapter.position
    json.background_image do
      json.url !chapter.background_image.blank? ? front_root_url + chapter.background_image.url : nil
    end
    json.sliders_entries_attributes do
      json.array! chapter.slider_entries do |slider_entry|
        json.id slider_entry.id
        json.file slider_entry.file ? front_root_url + slider_entry.file.url : nil
        json.position slider_entry.position
      end
    end
    json.musics_attributes do
      json.array! chapter.musics do |music|
        json.id music.id
        json.file music.file ? front_root_url + music.file.url : nil
        json.type music.try(:type)
        json.title music.try(:title)
      end
    end
    json.voices_attributes do
      json.array! chapter.voices do |voice|
        json.id voice.id
        json.file voice.file ? front_root_url + voice.file.url : nil
        json.type voice.try(:type)
        json.title voice.try(:title)
        json.soundable_id voice.soundable_id
        json.soundable_type voice.soundable_type
      end
    end
  end
end
