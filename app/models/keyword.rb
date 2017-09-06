class Keyword < ActiveRecord::Base
  include Labelized

  has_many :keyword_opuses
  has_many :opuses, through: :keyword_opuses
  
  def self.filter(label)
    where('label LIKE ?', "#{label}%")
  end
end
