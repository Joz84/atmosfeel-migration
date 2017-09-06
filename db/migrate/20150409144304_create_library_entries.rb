class CreateLibraryEntries < ActiveRecord::Migration
  def change
    create_table :library_entries do |t|
      t.references :opus, :feellist
    end
    add_foreign_key :library_entries, :opuses, on_delete: :cascade
  end
end
