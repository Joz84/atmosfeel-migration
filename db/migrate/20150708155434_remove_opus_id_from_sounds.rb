class RemoveOpusIdFromSounds < ActiveRecord::Migration
  def self.up
    remove_foreign_key :sounds, :opuses
    Sound.find_each do |sound|
      sound.update(soundable_id: sound.opus_id, soundable_type: 'Opus')
    end
    remove_column :sounds, :opus_id
  end

  def self.down
    add_column :sounds, :opus_id, :integer
  end
end
