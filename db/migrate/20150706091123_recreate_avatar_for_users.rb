class RecreateAvatarForUsers < ActiveRecord::Migration
  def self.up
    User.find_each do |user|
      user.avatar.recreate_versions! if user.avatar?
    end
  end

  def self.down
  end
end
