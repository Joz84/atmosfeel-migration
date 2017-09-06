class CreateAtmospheres < ActiveRecord::Migration
  def change
    create_table :atmospheres do |t|
      t.string :label
    end
  end
end
