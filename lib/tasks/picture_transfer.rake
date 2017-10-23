
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


