class AddFixedIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :fixed_id, :string
    add_index :plans, :fixed_id, unique: true
  end
end
