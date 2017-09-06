class AddCounterCacheOpusToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :opuses_count, :integer, null:false, default: 0
    ids = Set.new
    Opus.all.each {|c| ids << c.user_id}
    ids.each do |user_id|
      User.reset_counters(user_id, :opuses)
    end
  end

  def self.down
    remove_column :users, :opuses_count
  end
end
