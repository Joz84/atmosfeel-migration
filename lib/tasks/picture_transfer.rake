
desc "This task transfer the avatar user to cloudinary"
task :avatars_transfer => :environment do
  User.all.each do |user|
    if user.avatar.file
      # id = user.id
      # photo_name = user.avatar.file.filename
      # url = "../atmosfeel-uploads/user/avatar/#{id}/#{photo_name}"
      identifier = user.avatar.file.identifier
      url = "https://res.cloudinary.com/dpilgpat0/#{identifier}"
      user.remote_avatar_url = url
      user.save
    end
  # ulpoader = Cloudinary::Uploader.upload(url)
  # new_url = ulpoader["secure_url"].split("https://res.cloudinary.com/dpilgpat0/").last
  end
end

desc "This task transfer the cover opus to cloudinary"
task :covers_transfer => :environment do
  Opus.all.each do |opus|
    if opus.cover.file
      id = opus.id
      photo_name = opus.cover.file.filename
      url = "../atmosfeel-uploads/opus/cover/#{id}/#{photo_name}"
      opus.remote_cover_url = url
      opus.save
    end
  end
end

desc "This task transfer the background_image chapter to cloudinary"
task :background_images_transfer => :environment do
  Chapter.all.each do |chapter|
    if chapter.background_image.file
      id = chapter.id
      photo_name = chapter.background_image.file.filename
      url = "../atmosfeel-uploads/chapter/background_image/#{id}/#{photo_name}"
      chapter.remote_background_image_url = url
      chapter.save
    end
  end
end

desc "This task transfer the file slider entry to cloudinary"
task :slider_entry_file_transfer => :environment do
  SliderEntry.all.each do |slider_entry|
    if slider_entry.file.file
      id = slider_entry.id
      photo_name = slider_entry.file.file.filename
      url = "../atmosfeel-uploads/slider_entry/file/#{id}/#{photo_name}"
      slider_entry.remote_file_url = url
      slider_entry.save
    end
  end
end

desc "This task transfer the file music to cloudinary"
task :music_file_transfer => :environment do
  Music.all.each do |music|
    if music.file.file
      id = music.id
      photo_name = music.file.file.filename
      url = "../atmosfeel-uploads/music/file/#{id}/#{photo_name}"
      music.remote_file_url = url
      music.save
    end
  end
end

