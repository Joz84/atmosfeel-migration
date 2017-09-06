class AddCounterCacheOpusToAtmospheres < ActiveRecord::Migration
  def self.up
    add_column :atmospheres, :opuses_count, :integer, null:false, default: 0
    ids = Set.new
    Opus.all.each {|c| ids << c.atmosphere_id}
    ids.each do |atmosphere_id|
      Atmosphere.reset_counters(atmosphere_id, :opuses)
    end
  end

  def self.down
    remove_column :atmospheres, :opuses_count
  end
end
