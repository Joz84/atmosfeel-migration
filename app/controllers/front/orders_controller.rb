class Front::OrdersController < FrontController
  protect_from_forgery except: :payplug_ipn
  
  before_filter :authenticate_user!, only: :history

  def confirm
  end

  def cancel
  end

  def history
    @opuses = current_user.owned_opuses
  end

  def payplug_ipn
    logger.info request.headers.inspect
    @payplug_ipn = PayplugIpn.new(request, payplug_ipn_params)
    @payplug_ipn.execute
    ipn_valid = @payplug_ipn.valid?
    status = ipn_valid ? 200 : 401
    render text: "#{ipn_valid}", status: status
  end

  private

  def payplug_ipn_params
    # think to detail params in the ipn and add needed one in transaction ...
    # {"state": "paid", "customer", "2", "transaction_id": 4121, "custom_data": "29", "order": "42"}
    params.permit(:state, :customer, :transaction_id, :custom_data, :order)
  end
end
