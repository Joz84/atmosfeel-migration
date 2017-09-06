class TurnPricesToDecimal < ActiveRecord::Migration
  def self.up
    change_column :opuses, :price, :decimal, precision: 8, scale: 2
    change_column :plans, :price, :decimal, precision: 8, scale: 2
    change_column :items, :price, :decimal, precision: 8, scale: 2
  end

  def self.down
    change_column :opuses, :price, :float
    change_column :plans, :price, :float
    change_column :items, :price, :float
  end
end
