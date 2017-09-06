require 'test_helper'

class Front::AgreementsControllerTest < ActionController::TestCase
  test "should find an agreement when token is set on paypal_return" do
    get :paypal_return, token: 'foobar'
    assert_not nil, assigns(:agreement)
  end

  test "should find an agreement when token is set on paypal_cancel" do
    get :paypal_cancel, token: 'foobar'
    assert_not nil, assigns(:agreement)
  end
end
