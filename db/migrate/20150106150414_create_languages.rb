class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :label
    end
  end
end
