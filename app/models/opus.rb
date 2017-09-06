require 'elasticsearch/model'

class Opus < ActiveRecord::Base
  include LocalUpload
  include PriceAttr
  include Elasticsearch::Model

  mount_uploader :cover, CoverUploader

  paginates_per 10

  belongs_to :user, counter_cache: true
  belongs_to :atmosphere, counter_cache: true
  belongs_to :play_time, counter_cache: true
  belongs_to :language, counter_cache: true
  has_many :keyword_opuses
  has_many :keywords, through: :keyword_opuses
  has_many :collaborations
  has_many :collaborators, -> { includes(collaborations: [:collaboration_type]) }, through: :collaborations, source: :user
  has_many :chapters
  has_many :slider_entries, through: :chapters
  has_many :musics, -> {where type: 'Music'}, as: :soundable
  has_many :voices, -> {where type: 'Voice'}, as: :soundable
  has_many :likes
  has_many :comments
  has_many :items
  has_many :validated_orders, -> { where status: 'validated' }, through: :items, source: :itemable, source_type: 'Order'
  has_many :user_opuses

  accepts_nested_attributes_for :collaborations, allow_destroy: true, reject_if: :valid_collaborations
  accepts_nested_attributes_for :chapters, allow_destroy: true, reject_if: :valid_chapters
  accepts_nested_attributes_for :keyword_opuses, allow_destroy: true#, reject_if: :valid_keyword_opuses
  accepts_nested_attributes_for :musics, allow_destroy: true, reject_if: :valid_musics
  accepts_nested_attributes_for :voices, allow_destroy: true, reject_if: :valid_voices

  after_initialize :defaults
  before_save :set_published_at, :set_selected_at, :set_keywords_list
  after_save :set_isbn
  after_create :set_first_published_opus_on_creator

  after_commit on: [:create] do
    logger.info 'created'
    __elasticsearch__.index_document
  end

  after_commit on: [:update] do
    logger.info 'update'
    __elasticsearch__.index_document refresh: true
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end

  # Tell to LocalUpload Module which attribute is used by carrierwave
  alias_attribute :carrierwave_attr, :cover

  delegate :label, to: :language, prefix: true

  validates :atmosphere_id, :play_time_id, :price, :title, :abstract, presence: true

  scope :experience, -> { where(atf_experience: true)}
  scope :marketplace, -> { where(atf_experience: false)}

  settings index: {
    analysis: {
      filter: {
        substring: {
          type: 'edge_ngram',
          min_gram: 1,
          max_gram: 10
        }
      },
      analyzer: {
        autocomplete: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w(lowercase substring)
        }
      }
    }
  } do
    mapping do
      indexes :title, analyzer: 'autocomplete', search_analyzer: 'standard'
      indexes :keywords_list, analyzer: 'autocomplete', search_analyzer: 'standard'
      indexes :user,
        type: 'object',
        properties: {
          title: {type: 'string', analyzer: 'autocomplete', search_analyzer: 'standard'}
        }
    end
  end

  def self.fonts
    [
      "IM Fell English",
      "Open Sans",
      "Droid Serif",
      "Indie Flower",
      "Abel"
    ]
  end

  # Manually build a query
  # see: http://is.gd/xSG04E
  def self.filter(filters = {})
    # hash format key val
    filters    = filters.delete_if {|k, v| v.to_s.empty? || v.to_s == '0' || v.to_s.blank? }
    order_attr = filters.extract!(:order_attr)
    order_val  = filters.extract!(:order_val)
    title_val  = filters.extract!(:title)
    page       = filters.extract!(:page)


    query = {
      "query" => {
        "filtered" => {}
      },
      "track_scores" => true,
    }

    if !filters.empty?
      query["query"]["filtered"]["filter"] = {"and" => []}

      filters.each do |key, value|
        if value.kind_of?(Array)
          query["query"]["filtered"]["filter"]["and"].push({ "terms" => { key.to_s => value } })
        else
          query["query"]["filtered"]["filter"]["and"].push({ "term" => { key.to_s => value.to_s } })
        end
      end
    end

    if !title_val.empty?
      query["query"]["filtered"]["query"] = {
        "multi_match" => {
          "query" =>    title_val[:title],
          "fields" => [
            "title",
            "user.title",
            "keywords_list"
          ]
        }
      }
    end

    if !order_attr.empty? && !order_val.empty?
      query["sort"] = {
        order_attr[:order_attr] => {
          "order" => order_val[:order_val],
          "missing" => "_last"
        }
      }
    end

    result = search(query)

    if page.empty?
      # Very High Limit can be reduced for performance
      result.per(500)
    else
      result = result.page(page[:page])
    end

    result.records
  end

  def self.home
    selection(2)
  end

  def self.news
    where(published: true).order(published_at: :desc).limit(6)
  end

  def self.selection(limit = 6)
    where(selected: true).order(selected_at: :desc).limit(limit)
  end

  def self.popularity
    order(likes_count: :desc).limit(6)
  end

  def self.show(id)
    includes(
      :atmosphere, :play_time, :language, :keywords, :musics, :user,
      :voices, :comments, :likes, :collaborators, :validated_orders, chapters: [:slider_entries]
    ).find(id)
  end

  def as_indexed_json(options={})
    self.as_json(
      include: { user: { only: :title} }
    )
  end

  def author_override?
    !author_override.to_s.empty?
  end

  def author_is_collaborator?
    !Collaboration.joins(:collaboration_type).where(opus_id: id).where('collaboration_types.label LIKE ?', '%Auteur%').first.nil?
  end

  def chapters_sliders_length
    chapters.map{ |chapter| !chapter.slider_entries.empty? }.count(true)
  end

  def publish!
    update_attribute(:published, 1)
  end

  def readed_by_user?(user)
    return false if user.nil?
    user_opuses.where(user: user).any?
  end

  private

  def defaults
    self.font_family ||= 'Open+Sans'
    self.font_color ||= '#000000'
  end

  def set_published_at
    set_at('published', 'published_at')
  end

  def set_selected_at
    set_at('selected', 'selected_at')
  end

  def set_at(attribute, attribute_at)
    if send(attribute) && send("#{attribute}_changed?", from: false, to: true)
      write_attribute(attribute_at, DateTime.now)
    end
  end

  def set_isbn
    if isbn.to_s.empty?
      self.isbn = "auto_#{id}"
      save
    end
  end

  def set_keywords_list
    self.keywords_list = keywords.map{ |keyword| keyword.label }.join(',')
  end

  def set_first_published_opus_on_creator
    user.update(first_published_opus: DateTime.now) if user.first_published_opus.nil?
  end

  # Check object validity if not valid it will be remove from the nested object
  def valid_keyword_opuses(attributes)
    !KeywordOpus.new(attributes.merge({opus_id: self.id})).valid?
  end

  def valid_collaborations(attributes)
    !Collaboration.new(attributes.merge({opus_id: self.id})).valid?
  end

  def valid_chapters(attributes)
    !Chapter.new(attributes.merge({opus_id: self.id})).valid?
  end

  def valid_musics(attributes)
    !Music.first_or_initialize(attributes.merge({soundable_id: self.id, soundable_type: 'Opus'})).valid?
  end

  def valid_voices(attributes)
    !Voice.first_or_initialize(attributes.merge({soundable_id: self.id, soundable_type: 'Opus'})).valid?
  end
end
