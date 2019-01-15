require_relative "static_array"

class DynamicArray
  attr_reader :length
  
  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(@length - 1)
    @store[-1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize!
    store[length] = val 
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    (1..length - 1).each do |i|
      curr = @store[i]
      break unless curr
      @store[i - 1] = curr
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize!
    (length - 1).downto(0) do |i|
      curr = @store[i]
      next unless curr
      @store[i+1] = curr
    end
    @store[0] = val
    p @store
    @length += 1
  end  

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length || @length == 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length == @capacity
      @capacity *= 2
      new_store = StaticArray.new(@capacity)
      i = 0
      while i < @store.length
        new_store[i] = @store[i]
        i += 1
      end

      @store = new_store
    end
  end
end
