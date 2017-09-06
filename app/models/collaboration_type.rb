class CollaborationType < ActiveRecord::Base
  validates :label, presence: true
end
