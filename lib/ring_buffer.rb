require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
    check_index(@length - 1)
    @store[length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity
    @store[(length + @start_idx) % capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    @start_idx += 1
    @length -= 1
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == @capacity
    @start_idx -= 1
    unless store[@start_idx % @capacity]
      result = StaticArray.new(@capacity)
      (1..@length).each do |i|
        p result
        result[i + @start_idx % @capacity] = @store[i - 1]
      end
      result[@start_idx % @capacity] = val
    end
    @length += 1
    @store = result
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= length || length == 0
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      new_store[i] = store[i]
    end
    store = new_store
  end

end
