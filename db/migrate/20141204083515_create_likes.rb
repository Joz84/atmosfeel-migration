class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :opus
      t.belongs_to :user
    end
    add_foreign_key :likes, :opuses, on_delete: :cascade
    add_index :likes, [ :opus_id, :user_id ], unique: true
  end
end
