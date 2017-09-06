class CreatePlayTimes < ActiveRecord::Migration
  def change
    create_table :play_times do |t|
      t.string :label
    end
  end
end
