class CreateKeywordOpuses < ActiveRecord::Migration
  def change
    create_table :keyword_opuses do |t|
      t.belongs_to :keyword
      t.belongs_to :opus
    end
    add_foreign_key :keyword_opuses, :keywords, on_delete: :cascade
    add_foreign_key :keyword_opuses, :opuses, on_delete: :cascade
  end
end
