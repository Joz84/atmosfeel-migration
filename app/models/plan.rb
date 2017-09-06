class Plan < ActiveRecord::Base
  include PriceAttr
  
  has_many :agreements

  validates :name, :description, :cycles, :price, presence: true
  validates :cycles, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 13
  }

  after_initialize :defaults
  after_create :paypal_create
  after_update :paypal_update
  after_destroy :paypal_destroy

  private

  def defaults
    self.state ||= 'CREATED'
    self.visible = true if visible.nil?
  end

  def paypal_create
    CreatePaypalPlanWorker.perform_async(id)
  end

  # After leaving the CREATED state PayPal plan attributes cannot be edited except the STATE
  def paypal_update
   UpdatePaypalPlanWorker.perform_async(id) if changed_attributes.any? {|k, v| ['visible'].include?(k)}
  end

  def paypal_destroy
    DestroyPaypalPlanWorker.perform_async(paypal_id)
  end
end
