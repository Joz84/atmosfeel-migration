class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :opus
      t.string :title
      t.text :content
      t.string :font_color
      t.string :background_image
      t.integer :position
      t.timestamps
    end
    add_foreign_key :chapters, :opuses, on_delete: :cascade
  end
end
