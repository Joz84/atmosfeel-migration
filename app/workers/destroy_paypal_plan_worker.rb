class DestroyPaypalPlanWorker
  include Sidekiq::Worker

  # A plan cannot be destroyed so we make it inactive
  def perform(paypal_plan_id)
    paypal_plan = PayPal::SDK::REST::DataTypes::Plan.new(id: paypal_plan_id)
    patch = {
      path: '/',
      value: {
        state: 'INACTIVE'
      },
      op: 'replace'
    }
    paypal_plan.update(patch)
  end
end