class AddDbConstrainsOnComments < ActiveRecord::Migration
  def change
    add_foreign_key :comments, :opuses, on_delete: :cascade
  end
end
