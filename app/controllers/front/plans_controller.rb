class Front::PlansController < FrontController
  before_filter :authenticate_user!

  def select
    plan = Plan.find_by_fixed_id(params[:fixed_id])
    agreement = Agreement.create(plan_id: plan.id, user_id: current_user.id)
    redirect_to agreement.approval_url
  end

  def discount
    discount_code = DiscountCode.find_by_value(params[:discount_code_value])
    if !discount_code.nil? && discount_code.in_validity_period?
      DiscountedAgreement.create(cycles: discount_code.cycles, user_id: current_user.id)
      redirect_to front_experience_path
    else
      redirect_to front_tarifs_path
    end
  end
end
