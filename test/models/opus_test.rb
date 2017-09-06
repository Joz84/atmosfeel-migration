require 'test_helper'

class OpusTest < ActiveSupport::TestCase
  setup do
    Opus.__elasticsearch__.index_name = 'opuses_test'
    Opus.__elasticsearch__.import(force: true)
    Opus.__elasticsearch__.refresh_index!
  end

  test 'filterable by atmosphere' do
    assert_equal 7, Opus.filter(atmosphere_id: 1).length
  end

  test 'filterable by play_time' do
    assert_equal 9, Opus.filter(play_time_id: 1).length
  end

  test 'filterable by atmosphere and play_time' do
    assert_equal 7, Opus.filter(atmosphere_id: 1, play_time_id: 1).length
  end

  test 'orderable by popularity' do
    assert_equal 5, Opus.filter(order_attr: 'likes_count', order_val: 'asc').first.id
    assert_equal 1, Opus.filter(order_attr: 'likes_count', order_val: 'desc').first.id
  end

  test 'orderable by price' do
    assert_equal 10, Opus.filter(order_attr: 'price', order_val: 'asc').first.id
    assert_equal 5, Opus.filter(order_attr: 'price', order_val: 'desc').first.id
  end

  test 'orderable by date' do 
    opuses_id = Opus.filter(order_attr: 'published_at', order_val: 'desc').map{|opus| opus.id}

    assert_equal [1, 5, 2, 6, 7, 3, 8, 9, 10, 11], opuses_id
  end

  test 'set published to true and save it set published_at to not nil' do
    opus = Opus.last
    opus.published = true
    opus.save
    assert_equal false, opus.published_at.nil?, opus.published_at
  end

  test 'filterable by title' do
    assert_equal 7, Opus.filter(title: 'en').first.id
  end

  test 'have an isbn with the format auto_#id by default' do
    opus = Opus.create(atmosphere_id: 1, play_time_id: 1, price: '6,66', title: 'foo', abstract: 'bar', user_id: 1)
    assert_equal "auto_#{opus.id}", opus.isbn
    opus_from_db = Opus.find(opus.id)
    assert_equal "auto_#{opus_from_db.id}", opus_from_db.isbn
  end
end
