class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :opus

  delegate :title, to: :user, prefix: true

  validates :content, presence: true

  def self.ordered
    order(created_at: :asc)
  end
end
