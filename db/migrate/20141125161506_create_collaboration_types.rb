class CreateCollaborationTypes < ActiveRecord::Migration
  def change
    create_table :collaboration_types do |t|
      t.string :label
    end
  end
end
