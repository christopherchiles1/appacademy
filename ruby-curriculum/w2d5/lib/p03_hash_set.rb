require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    resize! if num_buckets == count
    self[el] << el
    @count += 1
  end

  def remove(el)
    self[el].delete(el)
    @count -= 1
  end

  def include?(el)
    self[el].include?(el)
  end

  private

  attr_reader :store

  def [](el)
    # optional but useful; return the bucket corresponding to `el`
    store[el.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store

    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each { |el| insert(el) }
  end
end
