class Like < ActiveRecord::Base
  belongs_to :opus, counter_cache: true
  belongs_to :user

  before_destroy :update_opus_counter

  validates :opus_id, uniqueness: {scope: [:user_id]}

  private

  def update_opus_counter
    Opus.reset_counters(opus_id, :likes)
  end
end
