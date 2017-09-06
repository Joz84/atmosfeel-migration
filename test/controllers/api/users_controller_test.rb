require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  def setup
    sign_in User.first
  end

  def user_filter_give_id(filter, expected_id)
    post :filter, {query: filter}
    body = JSON.parse(response.body)
    assert_equal expected_id, body.first['id']
  end

  test "should give the first user" do
    user_filter_give_id 'Carbone', 1
  end

  test "should give the third user" do
    user_filter_give_id 'Abitbol', 3
  end

  test "should give only artist" do
    post :filter, {query: 'Bar'}
    body = JSON.parse(response.body)
    assert_equal false, body.any? {|user| user['id'] == 2}, body.inspect
  end
end
