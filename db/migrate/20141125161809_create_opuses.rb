class CreateOpuses < ActiveRecord::Migration
  def change
    create_table :opuses do |t|
      t.references :user, :atmosphere, :play_time
      t.float :price
      t.string :title
      t.text :abstract
      t.string :font_color
      t.string :font_family
      t.boolean :atf_experience
      t.boolean :published
      t.string :cover
      t.integer :likes_count, default: 0
      t.datetime :published_at
      t.timestamps
    end
    add_foreign_key :opuses, :users
    add_foreign_key :opuses, :atmospheres, on_delete: :nullify
    add_foreign_key :opuses, :play_times, on_delete: :nullify
  end
end
