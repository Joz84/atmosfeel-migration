class BetterConstrains < ActiveRecord::Migration
  def self.up
    remove_foreign_key :items, :opuses
    add_foreign_key :items, :opuses, on_delete: :cascade
    remove_foreign_key :opuses_logs, :opuses
    add_foreign_key :opuses_logs, :opuses, on_delete: :cascade
    remove_foreign_key :opuses_logs, :users
    add_foreign_key :opuses_logs, :users, on_delete: :cascade
    remove_foreign_key :orders, :users
    add_foreign_key :orders, :users, on_delete: :cascade
  end

  def self.down
  end
end
