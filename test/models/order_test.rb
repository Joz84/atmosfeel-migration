require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @items_to_transfert = Item.find([3, 4])
    @order = Order.find(1)
  end

  test "an existing order can receive products" do
    assert @order.items.length == 2
    @order.add_items(@items_to_transfert)
    assert @order.items.length == 4, @order.items.length
  end

  test "total give sum of all items" do
    order = Order.find(2)
    assert_equal 11.9, order.total 
  end

  test "total give sum of all items in cent" do
    order = Order.find(2)
    assert_equal 1190.to_s, order.total_in_cent.to_s 
  end

  test "end add all items to user" do
    order = Order.find(2)
    user  = User.find(2)

    assert_equal 1, order.user.default_feellist.opuses.length
    order.end
    assert_equal 3, order.user.default_feellist.opuses.length
  end
end
