class AddDefaultFlagToFeelists < ActiveRecord::Migration
  def self.up
    add_column :feellists, :default, :boolean, default: false
    User.find_each do |user|
      user.feellists.create(default: true, name: 'Ma feelist')
    end
  end

  def self.down
    Feelist.where(default: true).find_each do |feelist|
      feelist.destroy
    end
    remove_column :feellists, :default
  end
end
