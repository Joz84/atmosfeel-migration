class AddPaypalValidationsFieldsToAgreements < ActiveRecord::Migration
  def change
    add_column :agreements, :paypal_payment_status, :string
  end
end
