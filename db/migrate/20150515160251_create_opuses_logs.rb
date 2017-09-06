class CreateOpusesLogs < ActiveRecord::Migration
  def change
    create_table :opuses_logs do |t|
      t.belongs_to :user, :opus
      t.timestamps
    end
    add_foreign_key :opuses_logs, :users, on_delete: :nullify
    add_foreign_key :opuses_logs, :opuses, on_delete: :nullify
  end
end
