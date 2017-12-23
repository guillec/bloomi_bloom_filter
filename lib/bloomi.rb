require "bloomi/version"
require "pry"

module Bloomi
  class BloomFilter
    def initialize
      # Init a 8 bit array with value of 0
      @bit_array = BitArray.new
    end

    def array
      self.bit_array.array
    end

    def add_item(item)
      Digest::SHA1.digest(item.downcase.strip)
        .unpack("VVVV")
        .each do |hash_item|

        self.set_index(hash_item % self.bit_array.size)
      end
    end

    def contains?(item)
      Digest::SHA1.digest(item.downcase.strip)
        .unpack("VVVV")
        .each do |hash_item|

        if  self.array[hash_item % self.bit_array.size] == 1
          next
        else
          return false
        end
      end
    end

    protected
    attr_reader :bit_array

    def set_index(index)
      self.bit_array.set_bit(index)
    end
  end

  class BitArray
    include Enumerable

    attr_reader :array

    def initialize
      @array = Array.new(8,0)
    end

    def size
      self.array.size
    end

    def each
      self.array.each
    end

    def set_bit(index)
      self.array[index] = 1
    end
  end
end
