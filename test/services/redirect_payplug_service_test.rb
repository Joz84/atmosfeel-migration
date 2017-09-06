require 'test_helper'

class RedirectPayplugServiceTest < ActiveSupport::TestCase
  test "a free cart should redirect to the bibliofeel" do
    cart = Cart.find(3)
    assert_equal '/bibliofeel', RedirectPayplugService.exec(cart)
  end

  test "a non-free cart should redirect to payplug" do
    skip("require config/payplug_config.yml for test rails env")
    cart = Cart.find(2)
    assert RedirectPayplugService.exec(cart).include?('payplug'), RedirectPayplugService.exec(cart)
  end
end
