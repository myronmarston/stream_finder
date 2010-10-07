class MockStream
  def initialize(string)
    @char_array = string.chars.to_a
  end

  def read(count)
    @char_array.slice!(0, count)
  end
end
