class AddDefaultValuesForOpuses < ActiveRecord::Migration
  def up
    change_column :opuses, :atf_experience, :boolean, default: false
    change_column :opuses, :published, :boolean, default: false
  end

  def down
    change_column :opuses, :atf_experience, :boolean, default: nil
    change_column :opuses, :published, :boolean, default: nil
  end
end
