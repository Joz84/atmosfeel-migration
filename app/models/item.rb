class Item < ActiveRecord::Base
  belongs_to :opus
  belongs_to :itemable, polymorphic: true

  delegate :cover, :likes_count, :play_time, :isbn, :atf_experience, :atf_experience?, :cover?, :user_id, to: :opus

  validates :opus_id, uniqueness: {scope: [:itemable_id]}
end
