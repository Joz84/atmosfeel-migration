class UserOpus < ActiveRecord::Base
  belongs_to :user
  belongs_to :opus
end
