require 'test_helper'

class BloomiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bloomi::VERSION
  end

  def test_it_initializes_an_8_bit_array_to_0
    bloomi = Bloomi::BloomFilter.new
    assert_equal 8, bloomi.array.size
    assert_equal [0,0,0,0,0,0,0,0], bloomi.array
  end

  def test_it_adding_item_to_filter
    bloomi = Bloomi::BloomFilter.new
    bloomi.add_item("192.56.164")
    assert_equal [0,1,0,0,0,1,1,1], bloomi.array
  end

  def test_it_returns_true_if_bloom_filter_possibly_containes_item
    item   = "192.133.111"
    bloomi = Bloomi::BloomFilter.new
    bloomi.add_item(item)

    assert bloomi.contains?(item)

    item_not_included = "000.000.000"
    refute bloomi.contains?(item_not_included)
  end
end
