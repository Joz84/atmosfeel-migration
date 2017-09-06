class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :user
      t.belongs_to :opus
      t.belongs_to :collaboration_type
    end
    add_foreign_key :collaborations, :users, on_delete: :cascade
    add_foreign_key :collaborations, :opuses, on_delete: :cascade
    add_foreign_key :collaborations, :collaboration_types, on_delete: :nullify
  end
end
