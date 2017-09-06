require 'test_helper'

REQUEST_BODY = '{"order": "37", "amount": 300, "last_name": "Paul", "state": "paid", "custom_datas": null, "first_name": "Gabriel", "status": 0, "is_test": false, "origin": null, "customer": "11", "custom_data": null, "id_transaction": 1617248, "email": "lm1971@yahoo.com"}'

REQUEST_HEADERS = {"REQUEST_METHOD"=>"POST", "REQUEST_PATH"=>"/payplug-ipn", "PATH_INFO"=>"/payplug-ipn", "REQUEST_URI"=>"/payplug-ipn", "SERVER_PROTOCOL"=>"HTTP/1.0", "HTTP_VERSION"=>"HTTP/1.0", "HTTP_X_FORWARDED_FOR"=>"46.137.183.81", "HTTP_HOST"=>"beta.atmosfeel.fr", "HTTP_CONNECTION"=>"close", "CONTENT_TYPE"=>"application/json", "HTTP_PAYPLUG_SIGNATURE"=>"U6SSDTW/xgbyeDnGBlkE7CTQzYGxH88UHfg1Lq2pzfQu34E2RCukTqTHPLOxqeHsyzGeP9HMLVSWdu1j80oaYbykYxnPJ7Fa5ySi0TWAFY+0teUx/9fMBRrqmMe6wtXocEnP6kgd1+RiZmxkjIn/uynSW0F8KyHM4dd+YkJoVhyxkKpcdRRip1E01lzGI67idW0T7j1liNPiEdKP76n2lAPv423s89nxWnGGUUR90FKn6SFta6i38I53Bwjql9Z7AShq9efCiX5rQhJjMr4/PwC6sNOevHuPuJCiXkPSWlz8qzGgBlWKUdbtprX9M1L56Nfw77x5iHFlHFvvQf7HyQ=="}

class PayplugIpnTest < ActiveSupport::TestCase
  test "a an ipn" do
    mock_request = MiniTest::Mock.new
    mock_body = MiniTest::Mock.new
    mock_payplug_ipn_params = {order: 37}

    mock_body.expect(:string, REQUEST_BODY)

    mock_request.expect(:body, mock_body)
    mock_request.expect(:headers, REQUEST_HEADERS)

    payplug_ipn = PayplugIpn.new(mock_request, mock_payplug_ipn_params)
    assert payplug_ipn.valid?

    payplug_ipn.execute

    assert_equal 'validated', Order.find(37).status
  end
end
