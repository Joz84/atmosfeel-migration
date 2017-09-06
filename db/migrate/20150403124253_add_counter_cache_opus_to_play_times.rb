class AddCounterCacheOpusToPlayTimes < ActiveRecord::Migration
  def self.up
    add_column :play_times, :opuses_count, :integer, null:false, default: 0
    ids = Set.new
    Opus.all.each {|c| ids << c.play_time_id}
    ids.each do |play_time_id|
      PlayTime.reset_counters(play_time_id, :opuses)
    end
  end

  def self.down
    remove_column :play_times, :opuses_count
  end
end
