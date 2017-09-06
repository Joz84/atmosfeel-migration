require 'sanitize'

class Chapter < ActiveRecord::Base
  include LocalUpload

  mount_uploader :background_image, PictureUploader

  has_many :slider_entries
  has_many :musics, -> {where type: 'Music'}, as: :soundable
  has_many :voices, -> {where type: 'Voice'}, as: :soundable

  accepts_nested_attributes_for :slider_entries, allow_destroy: true, reject_if: :valid_slider_entries
  accepts_nested_attributes_for :musics, allow_destroy: true, reject_if: :valid_musics
  accepts_nested_attributes_for :voices, allow_destroy: true, reject_if: :valid_voices

  after_initialize :defaults
  before_save :sanitize_content

  # Tell to LocalUpload Module which attribute is used by carrierwave
  alias_attribute :carrierwave_attr, :background_image

  validates :content, presence: true

  private

  def defaults
    self.font_color ||= '#000000'
  end

  def sanitize_content
    self.content = Sanitize.fragment(content,
      elements: ['div', 'br', 'a'],
      attributes: {'div' => ['style'], 'a' => ['href']},
      protocols: {
        'a' => {'href' => ['http', 'https']}
      },
      css: {
        properties: ['text-align']
      },
      add_attributes: {
        'a' => {'target' => '_blank'}
      }
    )
  end

  # Check object validity if not valid it will be remove from the nested object
  def valid_slider_entries(attributes)
    !SliderEntry.new(attributes.merge({chapter_id: self.id})).valid?
  end

  def valid_musics(attributes)
    !Music.first_or_initialize(attributes.merge({soundable_id: self.id, soundable_type: 'Chapter'})).valid?
  end

  def valid_voices(attributes)
    !Voice.first_or_initialize(attributes.merge({soundable_id: self.id, soundable_type: 'Chapter'})).valid?
  end
end
