class Cart < ActiveRecord::Base
  include TotalMath
  
  belongs_to :user
  has_many :items, as: :itemable
  has_many :opuses, -> { select('opuses.*, items.id as item_id') }, through: :items

  # dumb
  def self.find_with_opuses(id)
    result = joins(:opuses).where(carts: {id: id}).first
    if result.nil?
      find(id) 
    else
      result
    end
  end

  def add_item(opus_id)
    opus = Opus.find(opus_id)
    items.create(opus_id: opus_id, price: opus.price, title: opus.title)
    true
  end

  def remove_item(item_id)
    items.destroy(item_id)
  end

  def confirm
    order = user.orders.create
    order.add_items(items)
    order
  end
end
