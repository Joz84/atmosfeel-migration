class AddArtistInfosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :artist, :boolean, default: false
    add_column :users, :nickname, :string
    add_column :users, :resume, :text
    add_column :users, :avatar, :string
  end
end
