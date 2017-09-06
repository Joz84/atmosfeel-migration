class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :opus
  belongs_to :collaboration_type

  validates :user_id, :collaboration_type_id, presence: true
  validates :user_id, uniqueness: {scope: [:opus_id, :collaboration_type_id]}
end
