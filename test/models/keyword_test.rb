require 'test_helper'

class KeywordTest < ActiveSupport::TestCase
  test "filterable by label" do
    assert_equal 1, Keyword.filter('m').first.id
    assert_equal 2, Keyword.filter('a').first.id
  end
end
