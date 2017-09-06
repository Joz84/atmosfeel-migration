class AddSoundableOnSounds < ActiveRecord::Migration
  def change
    add_column :sounds, :soundable_id, :integer
    add_column :sounds, :soundable_type, :string
  end
end
