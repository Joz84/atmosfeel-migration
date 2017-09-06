module Back::PlansHelper
  def plan_exist?(plan)
    plan.id.nil?
  end
end
