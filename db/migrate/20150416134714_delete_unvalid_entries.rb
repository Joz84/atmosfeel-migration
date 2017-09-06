class DeleteUnvalidEntries < ActiveRecord::Migration
  def self.up
    %w{ Agreement Atmosphere Cart Chapter Collaboration CollaborationType Comment Feellist Item Keyword KeywordOpus Language LibraryEntry Like Opus Order Plan PlayTime SliderEntry Sound User}.each do |klass|
      Object.const_get(klass).find_each do |model_entry|
        model_entry.delete if !model_entry.valid?
      end
    end
  end

  def self.down
  end
end
