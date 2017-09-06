class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.integer :cycles
      t.float :price
      t.string :paypal_id
      t.text :paypal_link
      t.string :state
    end
  end
end
