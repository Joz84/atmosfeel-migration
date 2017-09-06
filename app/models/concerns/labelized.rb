module Labelized
  extend ActiveSupport::Concern

  included do 
    validates :label, presence: true, uniqueness: true

    default_scope { order(label: :asc) }
  end

  class_methods do 
    def used
      where('opuses_count > 0')
    end
  end
end