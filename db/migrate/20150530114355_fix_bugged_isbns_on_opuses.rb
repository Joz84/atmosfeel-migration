class FixBuggedIsbnsOnOpuses < ActiveRecord::Migration
  def self.up
    Opus.where(isbn: 'auto_').find_each do |opus|
      opus.isbn = ''
      opus.save
    end
  end

  def self.down
  end
end
