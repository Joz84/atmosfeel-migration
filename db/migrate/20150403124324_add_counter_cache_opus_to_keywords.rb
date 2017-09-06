class AddCounterCacheOpusToKeywords < ActiveRecord::Migration
  def self.up
    add_column :keywords, :opuses_count, :integer, null:false, default: 0
    ids = Set.new
    Opus.all.each {|c| 
      c.keyword_opuses.each do |k|
        ids << k.keyword_id
      end
    }
    ids.each do |keyword_id|
      Keyword.reset_counters(keyword_id, :opuses)
    end
  end

  def self.down
    remove_column :keywords, :opuses_count
  end
end
