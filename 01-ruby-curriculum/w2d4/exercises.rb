puts "Order n**2 my_min"
def my_min(list)
  list.each do |start_elem|
    return start_elem if list.all? { |other_elem| start_elem <= other_elem }
  end
end
# p list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p  my_min(list)  # =>  -5

puts "Order n my_min"
def my_min2(list)
  lowest_number = list.first
  list.drop(1).each do |el|
    case el <=> lowest_number
    when -1
      lowest_number = el
    end
    lowest_number
  end
  lowest_number
end

# p list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min2(list)  # =>  -5

puts "Largest contiguous sub-sum Order n**2"

def largest_contiguous_subsum(list)
  subarrays = []
  list.each_with_index do |el, idx|
    subarray = []
    (0..list.length - idx).each do |range|
      subarray << list[idx..idx + range]
    end
    subarrays += subarray
  end
  max = nil
  subarrays.each do |subs|
    sum = subs.inject(0,:+)
    if max.nil? || sum > max
      max = sum
    end
  end
  max
end

# p list = [5, 3, -7]
# p largest_contiguous_subsum(list) # => 8

puts "Largest contiguous sub-sum Order ??"

def largest_contiguous_subsum2(list)
  best_sum = list.first
  cur_sum = list.first
  list.drop(1).each_with_index do |el, idx|
    cur_sum += el
    if el > cur_sum
      cur_sum = el
    elsif cur_sum < 0
      cur_sum = 0
    end
    if cur_sum > best_sum
      best_sum = cur_sum
    end
  end
  best_sum
end

list = [2, 6, -2, -8, -5, 3, 6]
p largest_contiguous_subsum2(list) # => 8
list1 = [-1, 3, 4, -2, 5, 3]
p largest_contiguous_subsum2(list1) # => 8
list2 = [1, 2, 3, 4]
p largest_contiguous_subsum2(list2)
