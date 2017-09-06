class AddPaypalIdToAgreements < ActiveRecord::Migration
  def change
    add_column :agreements, :paypal_id, :string
  end
end
