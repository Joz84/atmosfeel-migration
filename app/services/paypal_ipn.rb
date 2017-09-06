class PaypalIpn
  def initialize(params, force_url = false)
    @params = params
    @force_url = force_url
  end

  def valid_agreement
    if verified_ipn?
      p 'IPN verified'
      agreement = Agreement.find_by_paypal_id(paypal_id)
      if !agreement.nil? && !payment_completed?
        agreement.paypal_payment_status = payment_status
        agreement.save
        return true
      end
    end
    return false
  end

  private

  def payment_status
    @params[:payment_status].nil? ? 'Completed' : @params[:payment_status]
  end

  def payment_completed?
    payment_status != 'Completed'
  end

  # https://github.com/paypal/PayPal-Python-SDK/issues/69#issuecomment-73898820
  def paypal_id
    @params[:recurring_payment_id]
  end

  def base_url
    if Rails.env.production? || @force_url
     'https://www.paypal.com/cgi-bin/webscr'
    else
     'https://www.sandbox.paypal.com/cgi-bin/webscr'
    end
  end

  def http_params
    uri = Addressable::URI.new
    uri.query_values = @params.merge({cmd: '_notify-validate'})
    uri.query
  end

  def verified_ipn?
    res = Net::HTTP.get(Addressable::URI.parse("#{base_url}?#{http_params}"))
    res.include?('VERIFIED')
  end
end