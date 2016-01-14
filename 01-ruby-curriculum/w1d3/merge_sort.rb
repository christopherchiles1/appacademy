def merge_sort(arr)
  return arr if arr.length < 2
  half = arr.length / 2
  left = arr.take(half)
  right = arr.drop(half)
  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  merged = []
  until left.empty? || right.empty?
    if left.first < right.first
      merged << left.shift
    else
      merged << right.shift
    end
  end
  merged + left + right
end

def subsets(set)
  return [[]] if set.empty?
  value = set.last
  previous = subsets(set[0..-2])
  previous + previous.map { |el| el.dup << value }
end
