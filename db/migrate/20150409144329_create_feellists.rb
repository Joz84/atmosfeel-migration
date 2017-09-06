class CreateFeellists < ActiveRecord::Migration
  def change
    create_table :feellists do |t|
      t.references :user
      t.string :name
    end
    add_foreign_key :library_entries, :feellists, on_delete: :nullify
    add_foreign_key :feellists, :users, on_delete: :cascade
  end
end
