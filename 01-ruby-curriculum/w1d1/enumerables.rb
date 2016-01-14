# Overview of enumerable methods and blocks

class Array
  def my_each(&blk)
    blk ||= Proc.new {}
    self.length.times { |i| blk.call(self[i]) }
    self
  end

  def my_each_with_index(&blk)
    blk ||= Proc.new {}
    self.length.times { |i| blk.call(self[i], i) }
    self
  end

  def my_select(&blk)
    arr = []
    my_each { |el| arr << el if blk.call(el) }
    arr
  end

  def my_reject(&blk)
    arr = []
    my_each { |el| arr << el unless blk.call(el) }
    arr
  end

  def my_any?(&blk)
    my_each { |el| return true if blk.call(el) }
    false
  end

  def my_all?(&blk)
    my_each { |el| return false unless blk.call(el) }
    true
  end

  def my_flatten # recursive
    return self unless my_any? { |el| el.is_a?(Array) }
    arr = []
    my_each { |el| arr += (el.is_a?(Array) ? el.my_flatten : [el]) }
    arr
  end

  def my_zip(*args)
    matrix = []
    self.my_each_with_index do |el, i|
      row = [el]
      args.my_each { |arr| row << arr[i] }
      matrix << row
    end
    matrix
  end

  def my_rotate(shift = 1)
    shift = shift % self.length
    self[shift..-1] + self[0...shift]
  end

  def my_join(delimeter = "")
    string = ""
    self[0...-1].my_each_with_index do |el, idx|
      string << el.to_s + delimeter
    end
    string << self.last
  end

  def my_reverse
    reversed = []
    self.my_each { |el| reversed.unshift(el) }
    reversed
  end
end
