class CreateBankDetails < ActiveRecord::Migration
  def change
    create_table :bank_details do |t|
      t.belongs_to :user
      t.string :iban
      t.string :bic
      t.string :owner_firstname
      t.string :owner_lastname
      t.text :owner_address
    end
    add_foreign_key :opuses, :users, on_delete: :cascade
  end
end
