class AddFirstPublishedOpusesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_published_opus, :datetime, default: nil
    User.find_each do |user|
      first_opus = user.opuses.first
      user.update(first_published_opus: first_opus.created_at) if !first_opus.nil?
    end
  end

  def self.down
    remove_column :users, :first_published_opus
  end
end
