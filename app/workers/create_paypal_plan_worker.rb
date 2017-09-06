class CreatePaypalPlanWorker
  include Sidekiq::Worker

  def perform(plan_id)
    plan = Plan.find(plan_id)
    # Create the plan on PayPal
    paypal_plan = PayPal::SDK::REST::DataTypes::Plan.new(
      name: plan.name,
      description: plan.description,
      type: 'FIXED', 
      payment_definitions: [
        {
          name: plan.name,
          type: 'REGULAR',
          frequency_interval: '1',
          frequency: 'MONTH',
          cycles: plan.cycles, 
          amount: {
            currency: 'EUR',
            value: plan.price
          }
        }
      ],
      merchant_preferences: {
        cancel_url: PaypalUrls[:cancel_url],
        return_url: PaypalUrls[:return_url]
      }
    )
    paypal_plan.create
    plan.paypal_id = paypal_plan.id 
    plan.paypal_link = paypal_plan.links.select { |link| link.href.include?(plan.paypal_id) }.first.href
    # Active the plan on PayPal
    patch = {
      path: '/',
      value: {
        state: 'ACTIVE'
      },
      op: 'replace'
    }
    plan.state = 'ACTIVE' if paypal_plan.update(patch)

    plan.save
  end
end