class AddLanguageIdAndIsbnToOpuses < ActiveRecord::Migration
  def change
    add_column :opuses, :language_id, :integer
    add_column :opuses, :isbn, :string
    add_foreign_key :opuses, :languages, on_delete: :nullify
  end
end
