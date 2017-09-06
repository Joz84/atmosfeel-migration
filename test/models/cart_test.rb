require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @empty_cart = Cart.find(1)
    @cart = Cart.find(2)
  end

  def ids_from_collection(collection)
    collection.collect{|entry| entry.id}
  end

  test "can add a product to the cart" do
    assert @empty_cart.items.length == 0
    @empty_cart.add_item(1)
    assert @empty_cart.items.length == 1
  end

  test "can remove a product from a cart" do
    assert @cart.items.length == 1
    @cart.remove_item(2)
    assert @cart.items.length == 0
  end

  test "confirm the cart give an order with the products of the cart" do
    items_id_to_transfert = ids_from_collection(@cart.items)
    order = @cart.confirm
    assert order.id
    assert ids_from_collection(order.items) == items_id_to_transfert
  end

  def items_id(cart)
    cart.items.map{|item| item.id }.compact
  end
end
