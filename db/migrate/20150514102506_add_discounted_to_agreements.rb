class AddDiscountedToAgreements < ActiveRecord::Migration
  def change
    add_column :agreements, :discounted, :boolean, default: false
  end
end
