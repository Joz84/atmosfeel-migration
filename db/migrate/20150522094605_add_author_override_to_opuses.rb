class AddAuthorOverrideToOpuses < ActiveRecord::Migration
  def change
    add_column :opuses, :author_override, :string, default: nil
  end
end
