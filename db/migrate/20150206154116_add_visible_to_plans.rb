class AddVisibleToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :visible, :boolean
  end
end
