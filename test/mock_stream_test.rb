$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'mock_stream'
require 'test/unit'

class MockStreamTest < Test::Unit::TestCase
  def test_reads_the_given_number_of_characters
    ms = MockStream.new("abcdefghijklmnopqrstuvwxyz")
    assert_equal %w[a b], ms.read(2)
    assert_equal %w[c d e f], ms.read(4)
    assert_equal %w[g h i j k l m n], ms.read(8)
  end

  def test_reads_end_of_stream_properly
    ms = MockStream.new("abcdefg")
    assert_equal %w[a b c d e f g], ms.read(30)
    assert_equal [], ms.read(100)
    assert_equal [], ms.read(1000)
  end
end
