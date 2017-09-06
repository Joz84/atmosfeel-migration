class PlayTime < ActiveRecord::Base
  include Labelized
  
  has_many :opuses

  def self.default_scope
    order('cast(play_times.label AS unsigned) asc')
  end
end
