class Front::AgreementsController < FrontController
  protect_from_forgery except: :paypal_ipn

  before_filter :authenticate_user!, except: [:paypal_ipn]
  before_filter :set_agreement, only: [:paypal_return]
  before_filter :set_current_user_agreement, only: [:subscription, :update_subscription]

  def subscription
  end

  def update_subscription
  end

  def paypal_cancel
  end

  def paypal_return
    @agreement.execute
  end

  def paypal_ipn
    paypal_ipn = PaypalIpn.new(paypal_ipn_params)
    paypal_ipn.valid_agreement
    render text: '', status: 200
  end

  private


  def set_current_user_agreement
    @agreement = current_user.agreement_active
  end

  def paypal_ipn_params
    params.permit(:recurring_payment_id, :payment_status)
  end

  def paypal_params
    params.require(:token)
  end

  def set_agreement
    @agreement = Agreement.find_by_paypal_token(paypal_params)
  end
end
