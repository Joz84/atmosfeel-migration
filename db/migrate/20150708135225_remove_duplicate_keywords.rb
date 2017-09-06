# The purpose of this migration is to find any duplicate keyword
# delete it and fix the association between it and the opus

class RemoveDuplicateKeywords < ActiveRecord::Migration
  def self.up
    Keyword.find_each do |keyword|
      next if keyword.valid?
      keyword_replacement = Keyword.where('label LIKE ? AND id != ?', keyword.label, keyword.id).first
      keyword.keyword_opuses.update_all(keyword_id: keyword_replacement.id)
      Keyword.reset_counters(keyword_replacement.id, :opuses)
      keyword.keyword_opuses.destroy_all
      keyword.destroy
    end
  end

  def self.down
  end
end
