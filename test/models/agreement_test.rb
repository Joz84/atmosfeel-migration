require 'test_helper'

class AgreementTest < ActiveSupport::TestCase
  test "active should not be empty" do
    assert !Agreement.active.empty?
    assert_equal 1, Agreement.active.first.id
  end

  test "first Agreement should be active" do
    assert Agreement.first.is_active?
  end

  test "last Agreement should not be active" do
    assert !Agreement.last.is_active?
  end
end
