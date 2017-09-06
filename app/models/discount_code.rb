class DiscountCode < ActiveRecord::Base
  attr_accessor :months_of_validity

  validates :denomination, :value, :cycles, presence: true
  validates :value, uniqueness: true
  validates :cycles, :months_of_validity, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 13
  }

  before_create :set_validity_limit

  def in_validity_period?
    Time.now < validity_limit
  end

  private

  def set_validity_limit
    self.validity_limit = Time.now + months_of_validity.to_i.months
  end
end
