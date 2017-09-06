class FixIsbnOnOpuses < ActiveRecord::Migration
  def self.up
    Opus.find_each(&:save)
  end

  def self.down
  end
end
