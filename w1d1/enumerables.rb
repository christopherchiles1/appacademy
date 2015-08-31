# My Each ----------------------
puts "My Each Method:"

class Array
  def my_each(&blk)
    self.length.times do |index|
      blk.call(self[index])
    end
    self
  end

  def my_each_with_index(&blk)
    self.length.times do |index|
      blk.call(self[index], index)
    end
    self
  end


end

return_value = [1, 2, 3].my_each do |num|
   puts num
 end.my_each do |num|
   puts num
 end

 p return_value


# My Select ----------------------
puts ""
puts "My Select Method:"

class Array

  def my_select(&blk)
    arr = []
    self.my_each do |el|
      arr << el if blk.call(el)
    end
    arr
  end
end


a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []


# My Reject ----------------------
puts ""
puts "My Reject Method:"

class Array

  def my_reject(&blk)
    arr = []
    self.my_each do |el|
      arr << el unless blk.call(el)
    end
    arr
  end
end



a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]


# My Any ----------------------
puts ""
puts "My Any Method:"

class Array
  def my_any?(&blk)
    self.my_each do |el|
      return true if blk.call(el)
    end
    false
  end

  def my_all?(&blk)
    self.my_each do |el|
      return false unless blk.call(el)
    end
    true
  end
end

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

# My Flatten ----------------------
puts ""
puts "My Flatten Method:"



class Array
  def my_flatten
    arr = self
    while arr.my_any? { |el| el.is_a?(Array) }
      arr2 = []
      arr.my_each do |e|
        if e.is_a?(Array)
          e.my_each { |item| arr2 << item}
        else
          arr2 << e
        end
      end
      arr = arr2
    end
    arr
  end
end

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]


# My Zip ----------------------
puts ""
puts "My Zip Method:"

class Array
  def my_zip(*args)
    output_arr = []
    self.each_with_index do |el, idx|
      temp = [el]
      args.each_index do |i|
        temp << args[i][idx]
      end
      output_arr << temp
    end
    output_arr
  end
end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]


# My Rotate ----------------------
puts ""
puts "My Rotate Method:"

class Array
  def my_rotate(num = 1)
    self[(num % self.length)..-1] + self[0...(num % self.length)]
  end
end


a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# My join ----------------------
puts ""
puts "My join Method:"

class Array
  def my_join(delimeter = "")
    output = ""
    self.my_each_with_index do |el, idx|
      output << el.to_s
      output << delimeter unless idx == self.length - 1
    end
    output
  end
end


a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"


# My Reverse ----------------------
puts ""
puts "My Reverse Method:"

class Array
  def my_reverse
    output_arr = []
    self.my_each { |el| output_arr.unshift(el) }
    output_arr
  end

end


p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
