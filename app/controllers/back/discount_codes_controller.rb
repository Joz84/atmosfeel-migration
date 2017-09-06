class Back::DiscountCodesController < BackController
  before_action :set_discount_code, only: [:show, :edit, :update, :destroy]

  def index
    @discount_codes = DiscountCode.all
  end

  def new
    @discount_code = DiscountCode.new
  end

  def edit
  end

  def create
    @discount_code = DiscountCode.new(discount_code_params)

    if @discount_code.save
      redirect_to back_discount_codes_path, notice: 'Discount code was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @discount_code.update(discount_code_params)
      redirect_to back_discount_codes_path, notice: 'Discount code was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @discount_code.destroy
    redirect_to back_discount_codes_path, notice: 'Discount code was successfully destroyed.'
  end

  private

  def set_discount_code
    @discount_code = DiscountCode.find(params[:id])
  end

  def discount_code_params
    params.require(:discount_code).permit(:denomination, :value, :cycles, :months_of_validity)
  end
end
