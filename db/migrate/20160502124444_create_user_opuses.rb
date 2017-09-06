class CreateUserOpuses < ActiveRecord::Migration
  def change
    create_table :user_opuses do |t|
      t.references :user, index: true
      t.references :opus, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_opuses, :users
    add_foreign_key :user_opuses, :opuses
  end
end
