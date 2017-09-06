class AddColorToAtmospheres < ActiveRecord::Migration
  def change
    add_column :atmospheres, :color, :string, default: nil
  end
end
