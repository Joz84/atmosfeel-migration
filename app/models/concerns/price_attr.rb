module PriceAttr
  extend ActiveSupport::Concern

  def price=(num)
    num = num.gsub(',','.') if num.is_a?(String)
    self[:price] = num
  end
end