require 'test_helper'

class Api::KeywordsControllerTest < ActionController::TestCase
  def setup
    sign_in User.first
  end

  def keyword_filter_give_id(filter, expected_id)
    post :filter, {:format => 'json', :label => filter}
    body = JSON.parse(response.body)
    assert_equal expected_id, body['keyword_opuses_attributes'].first['keyword_id']
  end

  test "should give the first keyword" do
    keyword_filter_give_id 'm', 1
  end

  test "should give the second keyword" do
    keyword_filter_give_id 'a', 2
  end

  test "can create a new keyword" do
    assert_equal 2, Keyword.count
    post :create, {label: 'foo'}
    body = JSON.parse(response.body)
    assert_equal 'foo', body['label']
    assert_equal 3, Keyword.count
  end
end
