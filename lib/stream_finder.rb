class StreamFinder
  class BadStreamError < StandardError; end

  def initialize(stream, first_read_size)
    @stream, @first_read_size = stream, first_read_size
  end

  # This method assumes that the stream is all 0's and 1's, and that it is all 1's after the first 1
  def find_first_index_of_1
    read_count, read_size = 0, @first_read_size

    while true
      content = @stream.read(read_size)

      case content.last
        when '1'
          return read_count + binary_search(content)
        when '0'
          read_count += read_size
          read_size *= 2
        when nil
          return nil
        else
          raise BadStreamError.new("The stream did not confirm to the expected format")
      end
    end
  end

  private

  def binary_search(array)
    midpoint = array.size / 2

    case array[midpoint]
      when '1'
        if midpoint.zero? || array[midpoint - 1] == '0'
          return midpoint
        end

        return binary_search(array.take(midpoint))
      when '0'
        return midpoint + binary_search(array.drop(midpoint))
      else
        raise BadStreamError.new("The stream did not confirm to the expected format")
    end
  end
end
