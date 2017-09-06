require 'test_helper'

PARAMS = {"payment_cycle"=>"Monthly", "txn_type"=>"recurring_payment_profile_created", "last_name"=>"Morgana", "next_payment_date"=>"03:00:00 Oct 02, 2015 PDT", "residence_country"=>"FR", "initial_payment_amount"=>"0.00", "currency_code"=>"EUR", "time_created"=>"02:25:15 Oct 02, 2015 PDT", "verify_sign"=>"AEZOYweg9uat3heVfmZSqm4kNn87ASnzpMfO8boz.uqjcDgCOepoIVl0", "period_type"=>" Regular", "payer_status"=>"unverified", "tax"=>"0.00", "payer_email"=>"laurentmorgana@yahoo.fr", "first_name"=>"Laurent", "receiver_email"=>"laurent@experience-atmosfeel.com", "payer_id"=>"CRNJDBXNR79KY", "product_type"=>"1", "shipping"=>"0.00", "amount_per_cycle"=>"9.90", "profile_status"=>"Active", "charset"=>"windows-1252", "notify_version"=>"3.8", "amount"=>"9.90", "outstanding_balance"=>"0.00", "recurring_payment_id"=>"I-W1M27YCH29C9", "product_name"=>"Abonnement pour 1 an - 9,90 \x80", "ipn_track_id"=>"1f01be3776f55"}

class PaypalIpnTest < ActiveSupport::TestCase
  test "a an ipn" do
    paypal_ipn = PaypalIpn.new(PARAMS, true)

    assert paypal_ipn.valid_agreement
  end
end
