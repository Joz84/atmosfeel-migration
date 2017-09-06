class PayplugPayment
  def initialize(user, order)
    @user = user
    @order = order
  end

  def redirect_url
    "#{pp_config.payment_url}?data=#{data}&sign=#{signature}"
  end

  private

  def data
    b64_data = Base64.encode64(url_params).gsub(/\n/, '')
    ERB::Util.url_encode(b64_data)
  end

  def pp_config 
    @pp_config ||= PayplugConfig.new
  end

  def signature
    private_key   = OpenSSL::PKey::RSA.new(pp_config.private_key)
    digest        = OpenSSL::Digest::SHA1.new
    signature     = private_key.sign(digest, url_params)
    b64_signature = Base64.encode64(signature).gsub(/\n/, '')

    ERB::Util.url_encode(b64_signature)
  end

  def url_params
    @url_params ||= set_url_params
  end

  def set_url_params
    uri = Addressable::URI.new
    uri.query_values = {
      amount: @order.total_in_cent,
      currency: 'EUR',
      ipn_url: PayplugUrls[:ipn_url],
      cancel_url: PayplugUrls[:cancel_url],
      return_url: PayplugUrls[:return_url],
      email: @user.email,
      first_name: @user.firstname,
      last_name: @user.lastname,
      order: @order.id,
      customer: @user.id
    }
    uri.query
  end
end