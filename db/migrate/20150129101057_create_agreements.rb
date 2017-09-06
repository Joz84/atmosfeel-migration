class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.belongs_to :plan
      t.belongs_to :user
      t.string :paypal_token
      t.text :approval_url
    end
    add_foreign_key :agreements, :plans, on_delete: :nullify
    add_foreign_key :agreements, :users, on_delete: :cascade
  end
end
