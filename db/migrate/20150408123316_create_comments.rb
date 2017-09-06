class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, :opus
      t.text :content
      t.timestamps
    end
  end
end
