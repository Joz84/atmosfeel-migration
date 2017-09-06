class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.timestamps
    end
    add_foreign_key :orders, :users, on_delete: :nullify
  end
end
