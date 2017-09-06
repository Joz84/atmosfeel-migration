module TotalMath
  extend ActiveSupport::Concern

  def total
    items.to_ary.delete_if {|item| item.id.nil? }.map{|item| item.price}.reduce(:+).to_f
  end

  def total_in_cent
    (total * 100).to_i
  end
end