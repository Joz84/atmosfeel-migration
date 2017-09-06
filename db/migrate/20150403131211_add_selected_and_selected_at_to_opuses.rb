class AddSelectedAndSelectedAtToOpuses < ActiveRecord::Migration
  def change
    add_column :opuses, :selected, :boolean, default: 0
    add_column :opuses, :selected_at, :datetime
  end
end
