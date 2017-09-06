class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :user
      t.timestamps
    end
    add_foreign_key :carts, :users, on_delete: :nullify
  end
end
