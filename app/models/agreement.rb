class Agreement < ActiveRecord::Base
  # Should I extract the paypal_description in a presenter ?
  include ActionView::Helpers::NumberHelper

  belongs_to :plan
  belongs_to :user

  validates :user_id, presence: true
  validates :plan_id, presence: true, if: -> { !discounted }

  after_initialize :defaults
  before_create :request_agreement

  delegate :fixed_id, to: :plan, prefix: true

  scope :completed, -> { where(paypal_payment_status: 'Completed')}
  scope :active, -> { where('DATE(created_at) <= ? AND DATE(end_at) >= ?', Time.now, Time.now) }

  def is_active?
    created_at.to_date <= Time.now.to_date && end_at.to_date >= Time.now.to_date && paypal_payment_status == 'Completed'
  end

  # called when the return_url path is displayed with the corresponding token params
  # ex : http://www.foo.com/return?token=EC-2VF70155057551704
  def execute
    ExecutePaypalAgreementWorker.perform_async(paypal_token)
  end

  def paypal_description
    I18n.t('paypal.agreement_description', agreement: model_name.human, description: plan.description, price: number_to_currency(plan.price))
  end

  private

  def defaults
    self.paypal_payment_status ||= 'Completed'
  end

  def request_agreement
    paypal_agreement = PayPal::SDK::REST::DataTypes::Agreement.new(
      name: plan.name, 
      description: paypal_description, 
      start_date: (Time.now + 1.hour).utc.iso8601,
      payer: {
        payment_method: 'paypal'
      },
      plan: {
        id: plan.paypal_id
      }
    )
    paypal_agreement.create
    self.paypal_id    = paypal_agreement.id
    self.end_at       = created_at + plan.cycles.months
    self.approval_url = paypal_agreement.links.select { |link| link.rel.include?('approval_url') }.first.href
    self.paypal_token = paypal_agreement.token
  end
end
