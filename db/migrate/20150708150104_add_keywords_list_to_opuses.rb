class AddKeywordsListToOpuses < ActiveRecord::Migration
  def change
    add_column :opuses, :keywords_list, :text, default: nil 
  end
end
