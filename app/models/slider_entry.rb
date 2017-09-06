class SliderEntry < ActiveRecord::Base
  include LocalUpload

  mount_uploader :file, PictureUploader

  belongs_to :chapter

  # Tell to LocalUpload Module which attribute is used by carrierwave
  alias_attribute :carrierwave_attr, :file

  validates :file, presence: true
end
