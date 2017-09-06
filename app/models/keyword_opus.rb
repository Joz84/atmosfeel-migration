class KeywordOpus < ActiveRecord::Base
  belongs_to :keyword, counter_cache: :opuses_count
  belongs_to :opus

  validates :keyword_id, uniqueness: {scope: [:opus_id]}
end
