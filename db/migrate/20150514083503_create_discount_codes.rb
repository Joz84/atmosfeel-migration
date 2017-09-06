class CreateDiscountCodes < ActiveRecord::Migration
  def change
    create_table :discount_codes do |t|
      t.string :denomination
      t.string :value
      t.integer :cycles
      t.datetime :validity_limit
    end
    add_index :discount_codes, :value, unique: true
  end
end
