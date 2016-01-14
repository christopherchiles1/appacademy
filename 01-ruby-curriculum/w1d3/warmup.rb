require 'byebug'
# def range(start, final)
#   #iterative
#   (start..final).inject([], &:<<)
# end

def range(start, final)
  return [] if final < start
  [start] + range(start + 1, final)
end

# def exp( base, power )
#   # recursion 1
#   return 1 if power == 0
#   base * exp(base, power - 1)
# end

def exp(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    square = exp(base, power / 2)
    square * square
  else
    square = exp(base, (power - 1) / 2)
    base * square * square
  end
end

class Array
  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
  end
end

def fibonacci(num)
  return [0] if num == 1
  return [0, 1] if num == 2
  array = fibonacci(num - 1)
  array << array[-2] + array[-1]
end

def bsearch(array, target)
    return nil if array.empty?

    half = array.length / 2
    case target <=> array[half]
    when -1
      left_result = bsearch(array.take(half), target)
      left_result ? left_result : nil
    when 0
      return half
    when 1
      right_result = bsearch(array.drop(half + 1), target)
      right_result ? half + right_result : nil
    end
end
