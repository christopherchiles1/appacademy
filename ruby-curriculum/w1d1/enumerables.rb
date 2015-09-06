class Array
  # my_each and my_each_with_index
  def my_each(&blk)
    blk ||= Proc.new {}
    self.length.times { |index| blk.call(self[index]) }
    self
  end

  def my_each_with_index(&blk)
    blk ||= Proc.new {}
    self.length.times { |index| blk.call(self[index], index) }
    self
  end

  # my_select
  def my_select(&blk)
    arr = []
    my_each { |el| arr << el if blk.call(el) }
    arr
  end

  # my_reject
  def my_reject(&blk)
    arr = []
    my_each { |el| arr << el unless blk.call(el) }
    arr
  end

  # my_any? and my_all?
  def my_any?(&blk)
    my_each { |el| return true if blk.call(el) }
    false
  end

  def my_all?(&blk)
    my_each { |el| return false unless blk.call(el) }
    true
  end

  # my_flatten (recursive)
  def my_flatten
    return self unless my_any? { |el| el.is_a?(Array) }
    arr = []
    my_each { |el| arr += (el.is_a?(Array) ? el.my_flatten : [el]) }
    arr
  end

  # my_zip
  def my_zip(*args)
    arr = []
    self.each_with_index do |el, idx|
      sub_arr = [el]
      args.each_index { |i| sub_arr << args[i][idx] }
      arr << sub_arr
    end
    arr
  end

  # my_rotate
  def my_rotate(shift = 1)
    shift = shift % self.length
    self[shift..-1] + self[0...shift]
  end

  # my_join
  def my_join(delimeter = "")
    joined = ""
    self.my_each_with_index do |el, idx|
      joined << el.to_s
      joined << delimeter unless idx == self.length - 1
    end
    joined
  end

  # my_reverse
  def my_reverse
    reversed = []
    self.my_each { |el| reversed.unshift(el) }
    reversed
  end
end
