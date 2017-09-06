class LibraryEntry < ActiveRecord::Base
  belongs_to :feellist
  belongs_to :opus

  delegate :cover, :likes_count, :price, :play_time, :atf_experience, :atf_experience?, :cover?, :user_id, to: :opus

  validates :opus_id, uniqueness: {scope: [:feellist_id]}

  paginates_per 9
end
