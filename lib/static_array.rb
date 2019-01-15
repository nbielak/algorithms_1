# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  attr_reader :length
  
  def initialize(length=0)
    @length = length
    @store = []
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index > @length
    @store[index] = value
  end

  protected
  attr_accessor :store
end
