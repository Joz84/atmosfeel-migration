class AddFlaggedToOpuses < ActiveRecord::Migration
  def change
    add_column :opuses, :flagged, :boolean, default: false
  end
end
