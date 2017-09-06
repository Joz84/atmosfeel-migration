require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    Opus.__elasticsearch__.index_name = 'opuses_test'
    Opus.__elasticsearch__.import(force: true)
    Opus.__elasticsearch__.refresh_index!
  end

  test "filterable by title" do
    assert_equal 1, User.filter('bone').first.id
    assert_equal 3, User.filter('bol').first.id
  end

  test "library_entries should return opuses in a feelist belongs to the user" do
    assert_equal [4, 5], User.first.library_entries.map{ |library_entry| library_entry.opus_id }
  end

  test "filtered_library_entries should return filtered opuses in a feelist belongs to the user filter by atmosphere" do
    assert_equal [4], User.first.filtered_library_entries(atmosphere_id: 1).map{ |library_entry| library_entry.id }
  end

  test "owned_opuses_ids should return an array of owned opuses id" do
    assert_equal [1,2], User.first.owned_opuses_ids
  end

  test "agreement_active? should return true if the user have an active agreement" do
    assert_equal true, User.first.agreement_active?
  end
end
