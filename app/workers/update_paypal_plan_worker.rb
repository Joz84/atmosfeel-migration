class UpdatePaypalPlanWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)
    paypal_plan = PayPal::SDK::REST::DataTypes::Plan.new(id: plan.paypal_id)
    patch = {
      path: '/',
      value: {
        state: state_label(plan.visible)
      },
      op: 'replace'
    }
    plan.state = state_label(plan.visible) if paypal_plan.update(patch)
    plan.save
  end

  def state_label(visible)
    visible ? 'ACTIVE' : 'INACTIVE'
  end
end