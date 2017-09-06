class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :opus
      t.float :price
      t.string :title
      t.integer :itemable_id
      t.string :itemable_type
      t.timestamps
    end
    add_foreign_key :items, :opuses, on_delete: :nullify
  end
end
