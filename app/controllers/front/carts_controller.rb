class Front::CartsController < FrontController
  before_filter :authenticate_user!, :set_cart

  def add
    @cart.add_item(params[:id])
    render :resume
  end

  def remove
    @cart.remove_item(params[:id])
    redirect_to front_carts_resume_path
  end

  def resume
  end

  def confirm
    redirect_to RedirectPayplugService.exec(@cart)
  end

  private 

  def set_cart
    if session[:cart_id].nil?
      @cart = current_user.carts.create
      session[:cart_id] = @cart.id
    else
      begin
        @cart = Cart.find_with_opuses(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        session[:cart_id] = nil
        set_cart
      end
    end
  end
end
