# http://payplug-developer-documentation.readthedocs.org/en/latest/#instant-payment-notification-ipn
class PayplugIpn
  def initialize(request, params)
    @order     = Order.find(params[:order])
    @body      = request.body.string#.gsub(/\//, '')
    @signature = Base64.decode64(request.headers["HTTP_PAYPLUG_SIGNATURE"])
  end

  def execute
    @order.end if valid?
  end

  def valid?
    public_key = OpenSSL::PKey::RSA.new(pp_config.public_key)
    digest     = OpenSSL::Digest::SHA1.new
    public_key.verify(digest, @signature, @body)
  end

  private

  def pp_config
    @pp_config ||= PayplugConfig.new
  end
end