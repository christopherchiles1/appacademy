# Overview of Recursion vs Iteration techniques

# range(a, b) returns an array of values from a to b
# - iterative method
def range(a, b)
  return [] if a < b
  (a..b).inject([], &:<<)
end
# - recursive method
def range(a, b)
  return [] if b < a
  [a] + range(a + 1, b)
end
# - tail recursive method (if Ruby had tail-recursion)
def range(a, b, arr = [])
  return arr if b < a
  range(a + 1, b, arr + [a])
end

## exp(b, p) returns the exponentiation b ** p for integer p values
# - recursive method
def exp(b, p)
  return nil if b.zero? && p.zero?
  return 1 if p.zero?
  b * exp(b, p - 1)
end
# - slightly faster recursive method
def exp(b, p)
  return nil if b.zero? && p.zero?
  return 1 if p.zero?
  return b if p == 1
  if p.even?
    part = exp(b, p / 2)
    part * part
  else
    part = exp(b, (p - 1) / 2)
    b * part * part
  end
end

## Array#deep_dup returns a deeply copied clone of the array
class Array
  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
  end
end

## fibonacci(num) returns an array of num fibonacci numbers, starting with 0
# - recursive method
def fibonacci(num)
  return (0...num).to_a if num <= 2
  arr = fibonacci(num - 1)
  arr << arr[-2] + arr[-1]
end
# - iterative method (better space complexity)
def fibonacci(num)
  return (0...num).to_a if num <= 2
  arr = [0, 1]
  (3..num).each { |i| arr << arr[-2] + arr[-1] }
  arr
end

## bsearch(arr, target) runs a binary search for a target on an array
def bsearch(arr, target)
    return nil if arr.empty?

    half = arr.length / 2
    case target <=> arr[half]
    when -1
      left_result = bsearch(arr.take(half), target)
      left_result ? left_result : nil
    when 0
      return half
    when 1
      right_result = bsearch(arr.drop(half + 1), target)
      right_result ? half + right_result : nil
    end
end
