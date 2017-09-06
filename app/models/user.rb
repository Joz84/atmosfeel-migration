class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_one :bank_detail
  has_many :user_opuses
  has_many :opuses
  has_many :likes
  has_many :agreements
  has_many :collaborations
  has_many :collaborated_opuses, -> { uniq }, through: :collaborations, source: :opus
  has_many :comments
  has_many :carts
  has_many :orders
  has_many :owned_opuses, -> { where(orders: {status: 'validated'}).uniq }, through: :orders, source: :items
  has_many :feellists
  has_many :library_entries, -> { where(opuses: {atf_experience: true}).includes(opus: [:atmosphere, :play_time, :keywords, :language]) }, through: :feellists
  has_many :liked_opuses, through: :likes, source: :opus

  before_save :set_title
  after_create :create_default_feellist

  validates :firstname, :lastname, presence: true
  validates :cgv, acceptance: true

  scope :artist, -> { where(artist: true)}

  def self.filter(query)
    where('title LIKE ?', "%#{query}%").limit(10)
  end

  def self.by_newsletter(newsletter_status = true)
    where(accepts_newsletter: newsletter_status)
  end

  def self.artist_index
    artist.order(first_published_opus: :desc)
  end

  def self.artist_order_by(order_params)
    if order_params[:val].to_s != '0'
      artist.order(order_params[:attr].to_sym => order_params[:val])
    else
      artist_index
    end
  end

  def agreement_active
    agreements.active.first
  end

  def agreement_active?
    agreements.completed.any?{ |agreement| agreement.is_active? }
  end

  def artist_show
    opuses + collaborated_opuses
  end

  def default_feellist
    feellists.where(default: true).first
  end

  def participated_opuses
    result = collaborated_opuses.each_with_object([]){ |opus, a| a << opus }
    opuses.each{ |opus| result << opus}
    result.uniq{ |opus| opus.id }
  end

  def like?(opus_id)
    !liked_opuses.where(id: opus_id).empty?
  end

  def like(opus_id)
    likes.create(opus_id: opus_id)
  end

  def unlike(opus_id)
    likes.where(opus_id: opus_id).first.destroy
  end

  def filtered_library_entries(filters = {})
    Opus.filter(filters.merge({id: ids_from_library_entries}))
  end

  def liked_library_entries(filters = {})
    Opus.filter(filters.merge({id: ids_from_liked_opuses}))
  end

  def owned_opuses_ids
    owned_opuses.map{ |owned_opus| owned_opus.opus_id }
  end

  def library_entries_opuses_ids
    library_entries.map{ |library_entry| library_entry.opus_id }
  end

  def library_entries_with_liked_opuses
    result = library_entries.each_with_object([]){ |library_entry, a| a <<  library_entry.opus}
    liked_opuses.each{ |opus| result << opus }
    result.uniq{ |opus| opus.id }
  end

  def participated_opuses_ids
    participated_opuses.map{ |opus| opus.id }
  end

  def after_database_authentication
    update_attribute(:authentication_token, nil)
  end

  private

  def create_default_feellist
    feellists.create(default: true, name: 'Ma feelist')
  end

  def set_title
    self.title = nickname.to_s.empty? ? "#{firstname} #{lastname}" : nickname
  end

  # Ids for experience opuses only
  def ids_from_library_entries
    @ids_from_library_entries ||= library_entries.map{ |entry| entry.opus_id }
  end

  def ids_from_liked_opuses
    @ids_from_liked_opuses ||= liked_opuses.map{ |opus| opus.id }
  end

  def ids_from_library_entries_with_liked_opuses
    @ids_from_library_entries_with_liked_opuses ||= library_entries_with_liked_opuses.map{ |opus| opus.id }
  end
end
