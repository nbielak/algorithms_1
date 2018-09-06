# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  attr_reader :length 
  
  def initialize(length=0)
    @store = Array.new(length)
    @length = length;
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    if index < length
      @store[index] = value
    end
    
  end

  protected
  attr_accessor :store
end
