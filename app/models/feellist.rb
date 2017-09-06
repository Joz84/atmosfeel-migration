class Feellist < ActiveRecord::Base
  belongs_to :user
  has_many :library_entries
  has_many :opuses, through: :library_entries

  validates :name, presence: true

  def add_library_entry(opus_id)
    library_entries.create(opus_id: opus_id)
  end
end
