class AvatarUploader < PictureUploader
  version :settings_profile do
    process resize_to_fill: [72,72]
  end

  version :mini do
    process resize_to_fill: [124,124]
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path('artist-card-placeholder.jpg')
  end
end