class DiscountedAgreement < Agreement
  attr_accessor :cycles

  skip_callback :create, :before, :request_agreement
  before_create :set_end_at

  private

  def set_end_at
    self.end_at = Time.now + cycles.months
  end

  def defaults
    super
    self.discounted = true
  end
end