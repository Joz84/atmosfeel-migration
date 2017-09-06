class AddAcceptsContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepts_contact, :boolean, default: false
  end
end
