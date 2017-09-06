class AddCounterCacheOpusToLanguages < ActiveRecord::Migration
  def self.up
    add_column :languages, :opuses_count, :integer, null:false, default: 0
    ids = Set.new
    Opus.all.each {|c| ids << c.language_id}
    ids.each do |language_id|
      Language.reset_counters(language_id, :opuses)
    end
  end

  def self.down
    remove_column :languages, :opuses_count
  end
end
