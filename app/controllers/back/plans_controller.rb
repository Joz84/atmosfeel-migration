class Back::PlansController < BackController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = Plan.all.includes(:agreements)
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to back_plans_path, notice: 'Plan was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to back_plans_path, notice: 'Plan was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @plan.destroy
    redirect_to back_plans_path, notice: 'Plan was successfully destroyed.'
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :description, :cycles, :price, :visible)
  end
end
