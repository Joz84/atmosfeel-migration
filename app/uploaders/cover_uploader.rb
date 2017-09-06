class CoverUploader < PictureUploader
  version :mini do
    process resize_to_fill: [300,400]
  end
  version :show do
    process resize_to_fill: [500,500]
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("atmosfeel-logo-alt-#{version_name || 'mini'}.jpg")
  end
end