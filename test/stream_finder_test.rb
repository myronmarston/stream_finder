$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'stream_finder'
require 'mock_stream'
require 'test/unit'

class StreamFinderTest < Test::Unit::TestCase
  def test_works_with_tiny_stream
    sf = StreamFinder.new(MockStream.new("01"), 10)
    assert_equal 1, sf.find_first_index_of_1
  end

  def test_works_with_bigger_stream
    sf = StreamFinder.new(MockStream.new('0' * 1000 + '1' * 500), 10)
    assert_equal 1000, sf.find_first_index_of_1
  end

  def test_raises_error_for_bad_stream
    sf = StreamFinder.new(MockStream.new("asdfkljdafsd"), 10)
    assert_raise(StreamFinder::BadStreamError) { sf.find_first_index_of_1 }
  end

  def test_returns_nil_when_no_1_found
    sf = StreamFinder.new(MockStream.new('0' * 1000), 10)
    assert_nil sf.find_first_index_of_1
  end
end
