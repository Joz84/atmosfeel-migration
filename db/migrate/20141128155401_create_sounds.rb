class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.belongs_to :opus
      t.string :file
      t.string :type
    end
    add_foreign_key :sounds, :opuses, on_delete: :cascade
  end
end
