class CreateSliderEntries < ActiveRecord::Migration
  def change
    create_table :slider_entries do |t|
      t.belongs_to :chapter
      t.string :file
      t.integer :position
    end
    add_foreign_key :slider_entries, :chapters, on_delete: :cascade
  end
end
