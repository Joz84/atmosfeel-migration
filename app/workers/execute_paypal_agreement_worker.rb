class ExecutePaypalAgreementWorker
  include Sidekiq::Worker

  # A plan cannot be destroyed so we make it inactive
  def perform(token)
    paypal_agreement = PayPal::SDK::REST::DataTypes::Agreement.new(
      token: token
    )
    paypal_agreement.execute
  end
end