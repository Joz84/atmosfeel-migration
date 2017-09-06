class RemoveDuplicateKeywordOpuses < ActiveRecord::Migration
  def self.up
    KeywordOpus.find_each do |keyword_opus|
      next if keyword_opus.valid?
      keyword_id = keyword_opus.keyword_id
      keyword_opus.destroy
      Keyword.reset_counters(keyword_id, :opuses)
    end
  end

  def self.down
  end
end
