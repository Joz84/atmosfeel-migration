class AddAcceptsNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepts_newsletter, :boolean, default: false
  end
end
