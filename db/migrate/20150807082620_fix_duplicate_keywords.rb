class FixDuplicateKeywords < ActiveRecord::Migration
  def self.up
    Keyword.find_each do |keyword|
      keyword_replacement = Keyword.where('label LIKE ? AND id != ?', keyword.label, keyword.id).first
      next if keyword_replacement.nil?
      keyword.keyword_opuses.update_all(keyword_id: keyword_replacement.id)
      Keyword.reset_counters(keyword_replacement.id, :opuses)
      keyword.keyword_opuses.destroy_all
      keyword.destroy
    end
  end

  def self.down
  end
end
