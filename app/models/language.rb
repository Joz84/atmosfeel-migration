class Language < ActiveRecord::Base
  include Labelized
  
  has_many :opuses
end
