class Sound < ActiveRecord::Base
  include LocalUpload

  mount_uploader :file, SoundUploader

  #belongs_to :opus
  belongs_to :soundable, polymorphic: true

  # Tell to LocalUpload Module which attribute is used by carrierwave
  alias_attribute :carrierwave_attr, :file

  validates :file, presence: true

  before_validation :set_default_title

  private

  def set_default_title
    default_title if self.title.to_s.length == 0
  end

  def default_title
    raise NotImplementedError
  end
end
