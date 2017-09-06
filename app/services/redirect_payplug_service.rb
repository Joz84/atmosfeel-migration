module RedirectPayplugService
  def self.exec(cart)
    order = cart.confirm

    if order.total > 0
      order.payment_url
    else
      order.end
      Rails.application.routes.url_helpers.front_bibliofeel_path
    end
  end
end